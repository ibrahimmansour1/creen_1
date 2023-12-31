import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/utils/laravel_exception.dart';
import '../../model/my_followers_model.dart';
import '../../repo/my_followers_repo.dart';

part 'followers_state.dart';

class FollowersCubit extends Cubit<FollowersState> {
  FollowersCubit({
    this.userId,
  }) : super(FollowersInitial());

  /// in case we wanna specificUser followers ...
  final int? userId;

  Future<void> getFollowers(context) async {
    emit(
      FollowersLoading(),
    );
    try {
      var followersData = await MyFollowersRepo.getMyFollowers(
        context,
        userId: userId,
      );

      if (followersData == null) {
        emit(FollowersDone());
        return;
      }
      if (followersData.status == true) {
        _followers = followersData.data;
        emit(FollowersDone());
      } else {
        emit(FollowersError());
      }
    } on LaravelException catch (error) {
      emit(FollowersError());
      Fluttertoast.showToast(
        msg: error.exception,
      );
    }
  }

  List<Followers>? _followers = [];
  List<Followers> get followers => [...?_followers];
  int get followersCounter => _followers?.length ?? 0;
  void changeFollowStatus({int? publisherId}) {
    var index =
        _followers?.indexWhere((element) => element.userFollowing == publisherId) ??
            -1;
    log('$index $publisherId', name: 'isFollow');
    if (index < 0) {
      return;
    }

    _followers?[index].userFollowers?.isFollow =
        !(_followers?[index].userFollowers?.isFollow ?? false);
    log('${_followers?[index].userFollowers?.isFollow}', name: 'isFollow');
    emit(
      FollowStateChanged(
        isFollow: _followers?[index].userFollowers?.isFollow ?? false,
        userId: publisherId ?? 0,
      ),
    );
  }
}
