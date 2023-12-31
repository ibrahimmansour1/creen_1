import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import '../../model/notification_model.dart';
import '../../repo/notifications_repo.dart';
import '../../repo/notification_count_repo.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  List<Notifications>? _notifications = [];
  int? _notificationsCount = 0;
  bool _hasNext = false;
  int _page = 1;

  List<Notifications> get notifications => [...?_notifications];

  int get notificationsCount => _notificationsCount ?? 0;
  var scrollController = ScrollController();

  Future<void> getNotifications(context) async {
    emit(
      _page > 1 ? NotificationsLoadingMore() : NotificationsLoading(),
    );

    try {
      var notificationsData = await NotificationsRepo.getNotifications(
        context,
        page: _page,
      );
      if (notificationsData == null) {
        emit(NotificationsError());
        return;
      }
      if (notificationsData.status == true) {
        if (_page > 1) {
          _notifications?.addAll(
            notificationsData.data!.data!.map((e) => e),
          );
        } else {
          _notifications = notificationsData.data?.data;
        }
        _hasNext = (notificationsData.data?.lastPage ?? 0) >
            (notificationsData.data?.currentPage ?? 0);
        if (_hasNext) {
          _page++;
        }
        emit(NotificationsDone());
      } else {
        emit(NotificationsError());
      }
    } catch (_) {
      emit(NotificationsError());
    }
  }

  Future<void> getNotificationsCount() async {
    emit(NotificationsLoadingCount());
    var countData = await NotificationsCountRepo.getNotificationsCount();

    if (countData == null) {
      return;
    }
    _notificationsCount = countData.data;
    emit(NotificationsDone());
  }

  void initScroller(context) {
    scrollController.addListener(() => _onScroll(context));
  }

  void _onScroll(context) {
    if (_hasNext &&
        scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      getNotifications(context);
    }
  }

  String modalImage({required String modal}) {
    switch (modal) {
      case 'Like':
      case 'LiveLike':

        return 'assets/images/love.png';
      //delete.png
      case 'User':
      case 'LiveUser':
        return 'assets/images/chat_icon.png';
      case 'Comment':
      // case 'LiveComment':
        return 'assets/images/commenttt.png';
      case 'Post':
      case 'LivePost':
        return 'assets/images/share.jpeg';
      /*  case 'delete':
        return 'assets/images/delete.png';*/
      case 'ProgramTimeline':
      default:
        return 'assets/images/logoo.png';
    }
  }
}
