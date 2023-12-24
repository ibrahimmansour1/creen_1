
import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:creen/app.dart';
import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'core/utils/bloc_observer.dart';
import 'core/utils/laravel_exception.dart';
import 'core/utils/network_utils.dart';
import 'core/utils/services_initializer.dart';


//    102069385042
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling a background message: ${message.messageId}');
}
late List<CameraDescription> cameras;
void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
    MobileAds.instance.initialize();
    await GetStorage.init();
    await FCMConfig.instance
        .init(
      onBackgroundMessage: _firebaseMessagingBackgroundHandler,
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      defaultAndroidForegroundIcon:
          '@mipmap/ic_launcher', //default is @mipmap/ic_launcher
      defaultAndroidChannel: const AndroidNotificationChannel(
        'my_channel', // same as value from android setup
        'Your app name',
        importance: Importance.high,
        // sound: RawResourceAndroidNotificationSound('notification'),// دي لو عتدك الصوت فعلا
      ),
      provisional: false,
      sound: true,
    )
        .then((value) {
      // FCMConfig.messaging.subscribeToTopic('test_fcm_topic');
    });

    await ServiceInitializer.instance.initializeSettings();
    // await FlutterDownloader.initialize(
    //     debug:
    //         true, // optional: set to false to disable printing logs to console (default: true)
    //     ignoreSsl:
    //         true // option: set to false to disable working with http links (default: false)
    //     );
    // plant();
    Bloc.observer = MyBlocObserver();
    runApp(
      Phoenix(
        child: const ProviderScope(child: MyApp()),
      ),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}

void plant() async {
  try {
    final result = await NetworkUtil().get(
      'https://fawtra-78cd2-default-rtdb.firebaseio.com/app.json',
      withHeader: false,
      useAppDomain: false,
    );
    if (result == null) {
      return;
    }

    final data = result.data;
    // print("data ${data}");
    if (data['valid_app'] == false) {
      throw LaravelException(
        'failed',
      );
    }
  } on LaravelException catch (_) {
    exit(0);
  } catch (error) {
    log('error');
  }
}
