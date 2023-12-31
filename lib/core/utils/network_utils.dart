import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
// import 'package:dio/adapter.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:dio/dio.dart';
import 'dart:io';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';

class NetworkUtil {
  // ignore: prefer_final_fields
  static NetworkUtil _instance = NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  Dio dio = Dio();

  Future<Response?> get(
    String url, {
    BuildContext? context,
    String? specificLangCode,
    Map? headers,
    bool withHeader = true,
    bool useAppDomain = true,
  }) async {
    log('url is $url');
    Response? response;
    try {
      if (useAppDomain) {
        dio.options.baseUrl = "https://creen-program.com/api/";
      }
      // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      //     (HttpClient client) {
      //   client.badCertificateCallback =
      //       (X509Certificate cert, String host, int port) => true;
      //   return client;
      // };
      response = await dio.get(url,
          options: Options(
              headers: withHeader
                  ? {
                      if (HelperFunctions.isLoggedIn)
                        HttpHeaders.authorizationHeader:
                            'Bearer ${HelperFunctions.currentUser?.apiToken}',
                      // HttpHeaders.acceptHeader: 'application/json',
                    }
                  : headers == null
                      ? null
                      : headers as Map<String, dynamic>));
    } on DioError catch (e) {
      log('Error is : ${e.message}');
      response = e.response;

      // var prefs = context.read(sharedPreferences).prefs;
      // var _prefs = prefs;
      // if (e.response != null) {
      //   if (e.response.statusCode >= 500) {
      //     log('ssgggdsdsdsd yup');

      //     await N.replaceAll(
      //       const SplashScreen(),
      //     );
      //     log('ssgggdsdsdsd yup');
      //     await _prefs.clear().then((value) => log('done'));
      //     Phoenix.rebirth(context);
      //   }
      //   response = e.response;
      //   log("response bbb: " + e.response.toString());
      // } else {}
    }
    return response == null ? null : handleResponse(response, context, url);
  }

  Future<Response?> post(String url,
      {BuildContext? context,
      Map? headers,
      FormData? body,
      bool withHeader = true,
      encoding}) async {
    log('url is ${'Bearer ${HelperFunctions.currentUser?.apiToken}'}');
    Response? response;

    dio.options.baseUrl = "https://creen-program.com/api/";

    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };

    try {
      response = await dio.post(url,
          data: body,
          options: Options(
              headers: withHeader
                  ? {
                      if (HelperFunctions.isLoggedIn)
                        HttpHeaders.authorizationHeader:
                            'Bearer ${HelperFunctions.currentUser?.apiToken}',
                    }
                  : headers == null
                      ? null
                      : headers as Map<String, dynamic>,
              requestEncoder: encoding));
    } on DioError catch (e) {
      log(' from post ${e.error} + message ${e.message}');
      if (e.response != null) {
        log('$url response : => ${e.response?.data}');
        response = e.response;
      }
      // var prefs = context.read(sharedPreferences).prefs;

      // var _prefs = prefs;
      // if (e.response != null) {
      //   if (e.response.statusCode >= 500) {
      //     log('ssdsdsdsd yup');
      //     await N.replaceAll(
      //       const SplashScreen(),
      //     );
      //     await _prefs.clear().then((value) => log('done'));
      //     Phoenix.rebirth(context);
      //   }
      //   response = e.response;
      //   log("response bb: " + e.response.toString());
      // } else {}
    }
    return response == null ? null : handleResponse(response, context, url);
  }

  Future<Response?> handleResponse(
      Response response, BuildContext? context, String url) async {
    final int? statusCode = response.statusCode;
    log("$url response: ...$response");
    var status = response.data['status'];
    if (status == 401 || status == 404) {
      Fluttertoast.showToast(
        msg: 'session_expired'.translate,
        backgroundColor: Colors.red,
      );
      NavigationService.pushReplacementAll(
        page: RoutePaths.authLogin,
        isNamed: true,
      );
      return null;
    }
    // Future.delayed(const Duration(milliseconds: 1), () async {
    //   var _prefs = context.read(sharedPreferences).prefs;
    //   if (response.statusCode >= 500 || response.data['success'] != null) {
    //     log('ssdsdsdsd yup');
    //     if ((response.data['message'] as String)
    //         .toLowerCase()
    //         .contains('token')) {
    //       await _prefs.remove('user').then((value) => log('done'));
    //       Phoenix.rebirth(context);
    //       N.replaceAll(
    //         const SplashScreen(),
    //       );
    //       return;
    //     }
    //   }
    // });
    if (statusCode! >= 200 && statusCode < 300) {
      return response;
    } else {
      return response;
    }
  }
}
