import 'package:creen/features/chat/viewModel/stories/stories_cubit.dart';
import 'package:creen/features/subject/viewModel/blogDetails/blog_details_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/features/follow/viewModel/followers/followers_cubit.dart';
import 'package:creen/features/profile/viewModel/profile/profile_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:fluttertoast/fluttertoast.dart';
import '../../../subject/viewModel/blogs/blogs_cubit.dart';
import '../../repo/follow_repo.dart';

part 'follow_state.dart';

class FollowCubit extends Cubit<FollowState> {
  FollowCubit() : super(FollowInitial());

  Future<bool> follow(
    context, {
    @required int? userId,
    required bool isFollow,
  }) async {
    changeFollowStatus(
      context,
      publisherId: userId,
    );
    emit(
      FollowLoading(
        userId: userId ?? 0,
      ),
    );
    try {
      var followData = await FollowRepo.follow(

        isFollow: isFollow,
        body: {
          'user_id': userId,
        },
      );
      if (followData == null) {
        Fluttertoast.showToast(
          msg: 'حدث خطأ ما يرجى إعادة المحاولة',
        );
        emit(FollowError());
        return false;
      }
      if (followData.status == false) {
        changeFollowStatus(
          context,
          publisherId: userId,
        );
      }
      emit(FollowDone());

      return followData.status ?? false;
    } catch (_) {
      emit(FollowError());
      return false;
    }
  }

  changeFollowStatus(
    BuildContext context, {
    int? publisherId,
  }) {
    try {
      context.read<BlogsCubit>().changeFollowStatus(
            publisherId: publisherId,
          );
    } catch (_) {}
    try {
      context.read<ProfileCubit>().changeFollowStatus(
            publisherId: publisherId,
          );
    } catch (_) {}
    try {
      context.read<FollowersCubit>().changeFollowStatus(
            publisherId: publisherId,
          );
    } catch (_) {}
    try {
      context.read<BlogDetailsCubit>().changeFollowStatus(
            publisherId: publisherId,
          );
    } catch (_) {}
    try {
      context.read<StoriesCubit>().changeFollowStatus(
            publisherId: publisherId,
          );
    } catch (_) {}
  }
}
