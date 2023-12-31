import 'dart:developer';

import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/network_utils.dart';
import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';

Future<void> fetchToken({
  required int uid,
  required String channelName,
  required int tokenRole,
}) async {
  final util = NetworkUtil();
  int tokenExpireTime = 7400; // Expire time in Seconds.
channelName = 'test';
  // Prepare the Url
  String url =
      '$serverUrl/rtc/$channelName/${tokenRole.toString()}/uid/${uid.toString()}?expiry=${tokenExpireTime.toString()}';

  // Send the request
  Response? response ;
  await util.get(
    url,
  ).then((value){
    response = value;
    log("fetch token response ====> $response");
  });

  if (response?.statusCode == 200) {
    // If the server returns an OK response, then parse the JSON.

    token = response?.data['rtcToken'];
    debugPrint('Token Received: $token');
    // Use the token to join a channel or renew an expiring token
    // setToken(newToken);
  } else {
    // If the server did not return an OK response,
    // then throw an exception.
    throw Exception(
        'Failed to fetch a token. Make sure that your server URL is valid');
  }
}


