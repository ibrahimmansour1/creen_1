import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
// import 'package:google_maps_flutter/google_maps_flutter.dart';

const kAppLogog = 'assets/images/creen_background.jpeg';

ValueNotifier<Locale> locale = ValueNotifier(const Locale('en', 'US'));

///////////////////////////////////////////////////////////
/// theme
///////////////////////////////////////////////////////////

ThemeData appTheme = ThemeData(
  appBarTheme: appBarTheme,
  primaryColor: MainStyle.primaryColor,
  fontFamily: 'Cairo',
  backgroundColor: Colors.grey[300],
  iconTheme: const IconThemeData(color: MainStyle.selectedIconColor),
);

AppBarTheme appBarTheme = const AppBarTheme(
    color: MainStyle.primaryColor,
    iconTheme: IconThemeData(color: MainStyle.selectedIconColor),
    elevation: 0.0,
    titleTextStyle: TextStyle(color: MainStyle.selectedIconColor));

///////////////////////////////////////////////////////////
/// Text Style
///////////////////////////////////////////////////////////

const String kMessage = 'message';
const String kExceptionMessage = 'There was an error please try again later';
const String kIsLoggedIn = 'logged in';
const String kToken = 'token';
const String kIsFirstTime = 'FirstTime';
const String storageKey = 'MyApplication_';
const String klanguage = 'language';
const String kcashedUserData = 'userData';
const Duration kDuration = Duration(milliseconds: 500);
// const LatLng defaultLatLng = LatLng(30.033333, 31.233334);
const googleMapAPIKey = 'AIzaSyDpI-Txo3DNdts1guCpNTiaKofVYJXKGcE';
const double defaultMapZoom = 17.0;
const double mediumMapZoom = 14.0;
const double locationArriveDistance = 200.0; //i
const int locationChangeInterval = 5000; //in milliseconds
const double locationChangeDistance = 5.0; //in meters
const Color liveBackground = Color(0xff0e2b33);

const appId = "8c21927ba87c4047a78428178283e345";
String channelName = "test";
String token = "";
// String token = "007eJxTYHjg0VJ5XNNuy43q+3LPeV2aZ7W+Pmu7MX6746bFtuYet+0VGCySjQwtjcyTEi3Mk00MTMwTzS1MjCwMzS2MLIxTjU1MOXdLpjYEMjLIvcpiYWSAQBCfhaEktbiEgQEASzgebg==";
// The base URL to your token server.
String serverUrl = "https://agora-token-server-zqf9.onrender.com"; // For example, "https://agora-token-service-production-92ff.up.railway.app"
int ? userId ;
bool isTokenExpiring = false;

// const String personProfile = 'assets/images/person.png';
const String personProfile = 'assets/images/personcopy.png';
const  String groupProfile = 'assets/images/groupcopy.png';
// const  String groupProfile = 'assets/images/group.png';
const  String liveBackgroundImage = 'assets/images/live_background.jpeg';
