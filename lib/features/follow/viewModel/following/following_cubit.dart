import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/core/utils/laravel_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../model/my_following_model.dart';
import '../../repo/my_following_repo.dart';

part 'following_state.dart';

class FollowingCubit extends Cubit<FollowingState> {
  FollowingCubit({
    this.userId,
  }) : super(FollowingInitial());

  /// in case we wanna specificUser following ...
  final int? userId;

  Future<void> getFollowing(context) async {
    emit(
      FollowingLoading(),
    );
    try {
      var followingData = await MyFollowingRepo.getMyFollowing(
        context,
        userId: userId,
      );

      if (followingData == null) {
        emit(FollowingDone());
        return;
      }
      if (followingData.status == true) {
        _following = followingData.data;
        emit(FollowingDone());
      } else {
        emit(FollowingError());
      }
    } on LaravelException catch (error) {
      emit(FollowingError());
      Fluttertoast.showToast(
        msg: error.exception,
      );
    }
  }

  List<Following>? _following = [];
  List<Following> get following => [...?_following];
  int get followingCounter => _following?.length ?? 0;
}
