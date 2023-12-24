import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:creen/core/themes/enums.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:creen/core/utils/widgets/register_text_field.dart';
import 'package:creen/features/Auth/repo/social_login_repo.dart';
import 'package:creen/features/Auth/viewModel/login/login_cubit.dart';
import 'package:creen/features/localization/manager/app_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:twitter_login/entity/auth_result.dart';
// import 'package:twitter_login/twitter_login.dart';
// import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/utils/widgets/loader_widget.dart';

/// The scopes required by this application.
const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/contacts.readonly',
];

/*GoogleSignIn googleSignInObject = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);*/
late GoogleSignIn googleSignInObject;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginCubit loginCubit;

/*
  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false; // has granted permissions?
  String _contactText = '';
  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    setState(() {
      _contactText = 'Loading contact info...';
    });
    var response ;
      NetworkUtil().get('https://people.googleapis.com/v1/people/me/connections'
        '?requestMask.includeField=person.names',headers: await user.authHeaders).then((value) {
 response = value;        });
   */
/* final http.Response response = await http.get(
      Uri.parse('https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );*/ /*

    if (response.statusCode != 200) {
      setState(() {
        _contactText = 'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      });
      print('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
    json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    setState(() {
      if (namedContact != null) {
        _contactText = 'I see you know $namedContact!';
      } else {
        _contactText = 'No contacts to display.';
      }
    });
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
          (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name = names.firstWhere(
            (dynamic name) =>
        (name as Map<Object?, dynamic>)['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  // This is the on-click handler for the Sign In button that is rendered by Flutter.
  //
  // On the web, the on-click handler of the Sign In button is owned by the JS
  // SDK, so this method can be considered mobile only.
  Future<void> _handleSignIn() async {
    try {
      await googleSignInObject.signIn().then((value) async{
        print("ggggggggggggggggggggoogle value $value");
        final googleAuth = GoogleAuthProvider.credential(accessToken: (await value?.authentication)!.accessToken);
        await FirebaseAuth.instance.signInWithCredential(googleAuth);
      });


    } catch (error) {
      print(error);
    }
  }
  Future<void> facebookLogin()async{
    FacebookAuth.instance.login().then((value) {
      print("facebook auth : ${value.status}");

      FacebookAuthProvider.credential((value.accessToken!.token));

    });
  }
*/

  @override
  void initState() {
    loginCubit = context.read<LoginCubit>();
    googleSignIn()
        .then((value) => log('Google Sign In', name: 'Login View'))
        .catchError((error) => log('Google Sign In Error ${error.toString()}',
            name: 'Login View'));
    /*googleSignInObject.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      // In mobile, being authenticated means being authorized...
      bool isAuthorized = account != null;
      // However, in the web...
      if (kIsWeb && account != null) {
        isAuthorized = await googleSignInObject.canAccessScopes(scopes);
      }

    */ /*  setState(() {
        _currentUser = account;
        _isAuthorized = isAuthorized;
      });

      // Now that we know that the user can access the required scopes, the app
      // can call the REST API.
      if (isAuthorized) {
        unawaited(_handleGetContact(account!));
      }*/ /*
    });
*/
    // In the web, googleSignInObject.signInSilently() triggers the One Tap UX.
    //
    // It is recommended by Google Identity Services to render both the One Tap UX
    // and the Google Sign In button together to "reduce friction and improve
    // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
    // googleSignInObject.signInSilently();
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Visibility(
          visible: Navigator.canPop(context),
          child: IconButton(
            onPressed: () {
              NavigationService.goBack();
            },
            color: Colors.white,
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/logoo.png"),
            Form(
              key: loginCubit.formKey,
              child: Column(
                children: [
                  RegisterTextField(
                    icon: (Icons.mail_outline),
                    label: 'enter_email_or_phone',
                    controller: loginCubit.emailOrPhoneController,
                    validator: loginCubit.emailValidator,
                  ),
                  const BoxHelper(
                    height: 10,
                  ),
                  RegisterTextField(
                    icon: (Icons.lock_outline_rounded),
                    label: 'enter_password',
                    obsecureText: true,
                    onChange: (v) {},
                    controller: loginCubit.passwordController,
                    validator: loginCubit.passwordValidator,
                  ),
                  const BoxHelper(
                    height: 10,
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      if (state is LoginLoading) {
                        return const LoaderWidget();
                      }
                      /*return CustomTextButton(
                          width: Sizes.screenWidth() * 0.7,
                          title: 'sign_in'.translate,
                          function: () => loginCubit.login(context),
                          radius: 25,
                        );*/
                      return InkWell(
                        onTap: () => loginCubit.login(context),
                        child: Container(
                          width: Sizes.screenWidth() * 0.7,
                          height: Sizes.screenHeight() * 0.07,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                          child: Text(
                            'sign_in'.translate,
                            textDirection:
                                localization.currentLanguage.toString() == 'en'
                                    ? TextDirection.ltr
                                    : TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const BoxHelper(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /*sign in with apple account*/
                      if(Platform.isIOS)
                      customCirecleAvatar(
                          icon: "assets/images/apple_icon.png",
                          isApple: true,
                          onPress: () async {
                           await appleSignIn();
                            // print("google");
                            // await _handleSignIn();
                            // await googleSignIn();
                          }),
                      customCirecleAvatar(
                          icon: "assets/images/google_icon.png",
                          onPress: () async {
                            // print("google");
                            // await _handleSignIn();
                            await _handleSignIn();
                          }),
                      customCirecleAvatar(
                          icon: "assets/images/facebook_icon.png",
                          onPress: () async {
                            if (kDebugMode) {
                              print("facebook");
                            }
                            facebookSignIn();
                          }),
                      customCirecleAvatar(
                          icon: "assets/images/x.jpeg",
                          isApple: true,
                          onPress: () async {
                            if (kDebugMode) {
                              print("twitter");
                            }
                            await twitterSignIn();
                          }),
                      customCirecleAvatar(
                          icon: "assets/images/wechat.png",
                          onPress: () {
                            if (kDebugMode) {
                              print("wechat");
                            }
                          }),
                    ],
                  ),
                  const BoxHelper(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                         Navigator.pushNamed(context,RoutePaths.forgetPassword );
                        },
                        child: Text(
                          'forget_password'.translate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            inherit: true,
                            shadows: [
                              Shadow(
                                  // bottomLeft
                                  offset: Offset(-1.5, -1.5),
                                  color: Colors.teal),
                              Shadow(
                                  // bottomRight
                                  offset: Offset(1.5, -1.5),
                                  color: Colors.teal),
                              Shadow(
                                  // topRight
                                  offset: Offset(1.5, 1.5),
                                  color: Colors.teal),
                              Shadow(
                                  // topLeft
                                  offset: Offset(-1.5, 1.5),
                                  color: Colors.teal),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          NavigationService.push(
                            page: RoutePaths.authRegister,
                            isNamed: true,
                          );
                        },
                        child: Text(
                          'create_new_account'.translate,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            inherit: true,
                            shadows: [
                              Shadow(
                                  // bottomLeft
                                  offset: Offset(-1.5, -1.5),
                                  color: Colors.teal),
                              Shadow(
                                  // bottomRight
                                  offset: Offset(1.5, -1.5),
                                  color: Colors.teal),
                              Shadow(
                                  // topRight
                                  offset: Offset(1.5, 1.5),
                                  color: Colors.teal),
                              Shadow(
                                  // topLeft
                                  offset: Offset(-1.5, 1.5),
                                  color: Colors.teal),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Sizes.screenHeight() * 0.03,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> googleSignIn() async {
    googleSignInObject = GoogleSignIn(
      // The OAuth client id of your app. This is required.
      // clientId: '28565525702-f86n3iq24lf9oanibrfabs9vgmpj0rtk.apps.googleusercontent.com',
      // If you need to authenticate to a backend server, specify its OAuth client. This is optional.
      // serverClientId: ...,
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
  }

  Future<void> _handleSignIn() async {
    try {
      await googleSignInObject
          .signIn()
          .then((auth) {
            log('Google Sign In Successfully $auth');
            loginCubit.accountType = Account.google.name;

            HelperFunctions.account(loginCubit.accountType).then((value) {
              SocialLoginRepo.socialLogin(email: auth!.email, name: auth?.displayName,cover: auth.photoUrl);

              NavigationService.pushAndRemoveUntil(
                page: RoutePaths.mainPage,
                isNamed: true,
                predicate: (p0) => false,
              );
            loginCubit.emit(LoginDone());
            });

          });
    } catch (error) {
      log('Google Sign In Process Error ${error.toString()} ',
          name: 'Login View');
    }
  }

  Future<void> appleSignIn() async {
    await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    ).then((value) {
      final credential = value;
      loginCubit.accountType = Account.apple.name;
      SocialLoginRepo.socialLogin(email: credential!.email!, name: credential?.givenName);

      HelperFunctions.account(loginCubit.accountType).then((value) => log(''));

      log('Apple Sign In Process $credential');
    }).catchError((error) {
      log('Apple Sign In Error ${error.toString()}');
    });
  }

  Future<void> facebookSignIn() async {
    // SocialLoginRepo.socialLogin(email: credential!.email!, name: credential?.givenName);

    loginCubit.accountType = Account.facebook.name;
    HelperFunctions.account(loginCubit.accountType).then((value) => log(''));

    /*  // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
     FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);*/
   /* final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile
// or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      log('Apple Sign In Process $accessToken');*/
      /*final AccessToken? accessToken = await FacebookAuth.instance.accessToken;
// or FacebookAuth.i.accessToken
      if (accessToken != null) {
        // user is logged
      }*/

      /*await FacebookAuth.instance.logOut();
// or FacebookAuth.i.logOut();*/

  /*  } else {
      log('Apple Sign In Error\n result status ${result.status}\n result message ${result.message}');

    }*/


  }

  Future<void> twitterSignIn() async {

    TwitterAuthProvider twitterProvider = TwitterAuthProvider();
    await FirebaseAuth.instance.signInWithProvider(twitterProvider).then((value) {
      SocialLoginRepo.socialLogin(email: value!.user!.email!, name:  value!.user?.displayName,cover:  value!.user!.photoURL);

      log('twitter login successful $value');
      loginCubit.accountType = Account.x.name;
      HelperFunctions.account(loginCubit.accountType).then((value) => log(''));

    }).catchError((error)=>log('twitter login error ${error.toString()}'));
   /* final twitter =  TwitterLogin(apiKey: "bKyqUCiMWO2WJASPfNt9PJOKC", apiSecretKey: "nK1jnRFj86jA8j8ofKyVFqE0Bd1BNHcmhhdOefW3fZvgG8RFW6", redirectURI: "https://creen-d9403.firebaseapp.com/__/auth/handler");
    // final twitter =  TwitterLogin(apiKey: "3UjokNGr2WDbrHp40XclLX6Yj", apiSecretKey: "jwqHCYybkgAX4Pf6GUYrP3ZAIJoaKcSM76qkfwNJ7akNkDR8bk", redirectURI: "https://creen-d9403.firebaseapp.com/__/auth/handler");
    //     final twitter =  TwitterLogin(apiKey: "3UjokNGr2WDbrHp40XclLX6Yj", apiSecretKey: "jwqHCYybkgAX4Pf6GUYrP3ZAIJoaKcSM76qkfwNJ7akNkDR8bk", redirectURI: "creen://");
    AuthResult authResult ;
    await twitter.login().then((value) async{
        authResult = value;
        log('Twitter Login process successed $authResult\n Login status ${authResult.status}\n Error Message ${authResult.errorMessage}\n Login auth ${authResult.authToken}');
      }).catchError((error)=>log('Twitter Login process failed ${error.toString()}'));
   */ /*  switch (authResult._st) {
        case TwitterLoginStatus.loggedIn:
        // success
          break;
        case TwitterLoginStatus.cancelledByUser:
        // cancel
          break;
        case TwitterLoginStatus.error:
        // error
          break;
      }*/

  }


}

Future<void> twitterLogin() async {
  /*
  final twitter =  TwitterLogin(apiKey: "3UjokNGr2WDbrHp40XclLX6Yj", apiSecretKey: "jwqHCYybkgAX4Pf6GUYrP3ZAIJoaKcSM76qkfwNJ7akNkDR8bk", redirectURI: "https://creen-d9403.firebaseapp.com/__/auth/handler");
await twitter.login().then((value) async{
  print("twitter value:- $value");
  final twitterAuth = TwitterAuthProvider.credential(accessToken: value.authToken!, secret: value.authTokenSecret!);
  await FirebaseAuth.instance.signInWithCredential(twitterAuth);
});*/
}

Widget customCirecleAvatar(
        {required String icon,
        bool isApple = false,
        required Function onPress}) =>
    InkWell(
      onTap: () => onPress(),
      child: Container(
        width: 40.r,
        height: 40.r,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isApple ? Colors.white : null,
            image: DecorationImage(image: AssetImage(icon), fit: BoxFit.cover)),
      ),
    );
