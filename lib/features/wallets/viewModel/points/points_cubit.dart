import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/features/wallets/repo/points_repo.dart';
import 'package:creen/features/wallets/repo/transfer_point_to_wallet_repo.dart';
import 'package:creen/features/wallets/repo/transfer_points_to_user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/points_model.dart';

part 'points_state.dart';

class PointsCubit extends Cubit<PointsState> {
  PointsCubit() : super(PointsInitial());
  var scrollController = ScrollController();
  var formKey = GlobalKey<FormState>();
  var pointsController = TextEditingController();
  var mobileController = TextEditingController();
  var _page = 1;
  var _hasNext = false;
  List<PointsData>? _points = [];
  num? _total;
  List<PointsData> get points => [...?_points];
  num? get total => _total;
  void initListeners() => scrollController.addListener(_onScroll);

  void _onScroll() {
    if (_hasNext &&
        scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      getPoints();
    }
  }

  Future<void> getPoints() async {
    emit(_page > 1 ? PointsLoadingMore() : PointsLoading());

    try {
      var pointsData = await PointsRepo.getPointss(
        page: _page,
      );
      if (pointsData == null) {
        emit(PointsError());
        return;
      }
      if (pointsData.status == true) {
        if (_page > 1) {
          _points?.addAll(pointsData.data!.points!.data!.map((e) => e));
        } else {
          _points = pointsData.data?.points?.data;
        }
        _total = pointsData.data?.total;
        _hasNext = pointsData.data?.points?.nextPageUrl != null;
        if (_hasNext) {
          _page++;
        }
      }
      emit(PointsDone());
    } catch (error) {
      emit(PointsError());
    }
  }

  Future<void> _transferPointsToUser() async {
    emit(TransferPointsLoading());

    try {
      var pointsData = await TransferPointsToUserRepo.transfer(
        body: {
          'points': pointsController.text,
          'mobile': mobileController.text,
        },
      );
      if (pointsData == null) {
        emit(PointsError());
        return;
      }
      Fluttertoast.showToast(
        msg: pointsData.message ?? '',
      );
      if (pointsData.status == true) {
        NavigationService.goBack();
      }
      emit(PointsDone());
    } catch (error) {
      emit(PointsError());
    }
  }

  Future<void> _transferPointsToWallet() async {
    emit(TransferPointsLoading());

    try {
      var pointsData = await TransferPointsToWalletRepo.transfer(
        body: {
          'points': pointsController.text,
          'mobile': HelperFunctions.currentUser?.mobile,
        },
      );
      if (pointsData == null) {
        emit(PointsError());
        return;
      }
      Fluttertoast.showToast(
        msg: pointsData.message ?? '',
      );
      if (pointsData.status == true) {
        NavigationService.goBack();
      }
      emit(PointsDone());
    } catch (error) {
      emit(PointsError());
    }
  }

  void clearFields() {
    mobileController.clear();
    pointsController.clear();
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    mobileController.dispose();
    pointsController.dispose();
    return super.close();
  }

  Future<void> transfer({required bool isGift}) async {
    var validate = formKey.currentState?.validate() ?? false;
    if (!validate) {
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    return isGift ? _transferPointsToUser() : _transferPointsToWallet();
  }
}
