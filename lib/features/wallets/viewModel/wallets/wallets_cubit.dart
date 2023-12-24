import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/wallets_model.dart';
import '../../repo/wallet_repo.dart';

part 'wallets_state.dart';

class WalletsCubit extends Cubit<WalletsState> {
  WalletsCubit() : super(WalletsInitial());
  var scrollController = ScrollController();
  var _page = 1;
  var _hasNext = false;
  List<WalletData>? _wallets = [];
  List<WalletData> get wallets => [...?_wallets];
  var _chargeType = 'whole';
  num? _total;
  num? _walletFromPoint;
  num? _walletFromGift;

  num? get total => _total;
  num? get walletFromPoint => _walletFromPoint;
  num? get walletFromGift => _walletFromGift;
  String get chargeType => _chargeType;

  void initListeners() => scrollController.addListener(_onScroll);

  void _onScroll() {
    if (_hasNext &&
        scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      getWallets();
    }
  }

  Future<void> getWallets() async {
    emit(_page > 1 ? WalletsLoadingMore() : WalletsLoading());
    try {
      var walletData = await WalletRepo.getWallets(
        page: _page,
      );
      if (walletData == null) {
        emit(WalletsError());
        return;
      }
      if (walletData.status == true) {
        if (_page > 1) {
          _wallets?.addAll(walletData.data!.wallets!.data!);
        } else {
          _wallets = walletData.data?.wallets?.data;
        }
        _total = walletData.data?.total;
        _walletFromGift = walletData.data?.walletFromGift;
        _walletFromPoint = walletData.data?.walletFromPoint;
        _hasNext = walletData.data?.wallets?.nextPageUrl != null;
        if (_hasNext) {
          _page++;
        }
      }
      emit(WalletsDone());
    } catch (error) {
      emit(WalletsError());
    }
  }

  void onWithdrawMethodChanged(String? value) {
    if (value == null) {
      return;
    }
    _chargeType = value;
    emit(WithdrawMethodStateChanged(withdrawType: _chargeType));

  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
