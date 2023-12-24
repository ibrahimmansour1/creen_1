import 'dart:developer';

import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/widgets/app_loader.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/features/drawer/presentaion/pages/naviigation_drawer.dart';
import 'package:creen/features/notifications/repo/notification_destroy_repo.dart';
import '../../repo/notification_destroy_all_repo.dart';
import '../widgets/notification_item.dart';
import 'package:creen/features/notifications/viewModel/notifications/notifications_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../../core/themes/themes.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationsCubit notificationsCubit;
  List<bool> erase = [];

  @override
  void initState() {
    notificationsCubit = context.read<NotificationsCubit>()
      ..initScroller(context)
      ..getNotifications(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('token => ${HelperFunctions.currentUser?.apiToken}');
    print("${'notifications'.translate}");
    return Scaffold(
      drawer: const NavigationDrawer(),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
          child: const CustomAppBar(
            back: true,
            title: 'notifications',
          )),
      body: Container(
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state is NotificationsLoading) {
              return const AppLoader();
            }
            if (notificationsCubit.notifications.isEmpty) {
              return Center(
                child: Text(
                  'notifications_empty'.translate,
                  style: MainTheme.authTextStyle.copyWith(fontSize: 16),
                ),
              );
            }
            return Container(
              decoration: const BoxDecoration(
                  /*  gradient: LinearGradient(colors: [
                  liveBackground,
// Color(0xff071B19) ,
                  Color(0xff07544E) ,
                ],
                  begin:Alignment.bottomRight,
                  end: Alignment.topLeft,
                  tileMode: TileMode.clamp,
                ),*/
                  image: DecorationImage(
                      image: AssetImage(liveBackgroundImage),
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    textDirection: TextDirection.ltr,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              if (erase.contains(true)) {
                                erase.clear();
                                erase = List<bool>.generate(
                                    notificationsCubit.notifications.length,
                                    (index) => false);
                              } else {
                                erase = List<bool>.generate(
                                    notificationsCubit.notifications.length,
                                    (index) => true);
                              }
                            });
                          },
                          child: const Text(
                            'تحديد الكل',
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                      ),
                      if (erase.contains(true))
                        InkWell(
                          onTap: () {
                            if(erase.every((e)=>e==true)){
                              // log('selected all');
                              NotificationDestroyAllRepo.destroyAllNotifications().then((value){});
                            }
                            else {
                              for (int ind = 0; ind < erase.length; ind++) {
                              if (erase[ind]) {
                                NotificationDestroyRepo.destroyNotification(id:notificationsCubit.notifications[ind].id! ).then((value){ setState(() {
                            /*      notificationsCubit.notifications
                                      .removeAt(ind);*/
                                  notificationsCubit.getNotifications(context);
                                  erase.removeAt(ind);
                                });});

                                return;
                              }
                            }
                            }
                          },
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        )
                    ],
                  ),
                  Expanded(
                    child: ListView(
                      controller: notificationsCubit.scrollController,
                      children: List.generate(
                        notificationsCubit.notifications.length,
                        (index) {
                          var singleNotification =
                              notificationsCubit.notifications[index];
                          // print("notifications modal ${singleNotification.model}");
                          // print("notifications modal id ${singleNotification.modelId}");
                          return NotificationItem(
                              singleNotification.content,
                              'show_details'.translate,
                              notificationsCubit.modalImage(
                                  modal: singleNotification.model!), () {
                            if (erase.isNotEmpty) {
                              log('erase[index] ${erase[index]}');
                              setState(() {
                                erase[index] = !(erase[index]);
                              });
                            } else {
                              if (singleNotification.url == null) {
                                return;
                              }
                              launchUrlString(
                                singleNotification.url ?? '',
                              );
                            }
                            // print("notifications modal ${singleNotification.readAt}");
                            // print("notifications modal id ${singleNotification.modelId}");
                          }, erase.isEmpty ? null : erase[index]);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
