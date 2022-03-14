import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:user/Locale/locales.dart';
import 'package:user/Routes/routes.dart';
import 'package:user/Theme/colors.dart';
import 'package:user/baseurl/baseurlg.dart';
import 'package:user/beanmodel/appinfo.dart';
import 'package:user/beanmodel/signinmodel.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  GoogleSignIn _googleSignIn;
  bool showProgress = false;
  bool enteredFirst = false;
  int numberLimit = 11;
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  AppInfoModel appInfoModeld;
  int checkValue = -1;
  List<String> languages = [];
  String selectLanguage = '';
  TextEditingController passwordController = TextEditingController();

  FirebaseMessaging messaging;
  dynamic token;

  int count = 0;

  String appNameA = '--';

  bool isNumberOk = false;

  @override
  void initState() {
    super.initState();
    // _languageCubit = BlocProvider.of<LanguageCubit>(context);
    hitAsyncInit();
    hitAppInfo();
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
  }

  void hitAsyncInit() async {
    try{
      FirebaseApp app;
      List<FirebaseApp> firebase = Firebase.apps;
      for (FirebaseApp appd in firebase) {
        if (appd.name == 'TheGroceryGuys') {
          app = appd;
          break;
        }
      }
      if (app == null) {
        if(Platform.isIOS){
          await Firebase.initializeApp(
            name: 'TheGroceryGuys',
            options: const FirebaseOptions(apiKey: 'AIzaSyCN5YHSeA-6rB4B4gApnjzAqffibeFD8WY',
                appId: '1:857676187722:ios:7735d516dcd902efb87eb3',
                messagingSenderId: '857676187722',
                projectId: 'thegroceryguys-68e6b'),
          );
        }else{
          await Firebase.initializeApp();
        }
      }
    }finally{
      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) {
        token = value;
      });
    }
  }

  void hitAppInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      showProgress = true;
    });
    var http = Client();
    http.post(appInfoUri, body: {'user_id': ''}).then((value) {
      // print(value.body);
      if (value.statusCode == 200) {
        AppInfoModel data1 = AppInfoModel.fromJson(jsonDecode(value.body));
        print('data - ${data1.toString()}');
        if (data1!=null && '${data1.status}' == '1') {
          setState(() {
            appInfoModeld = data1;
            appNameA = '${appInfoModeld.appName}';
            countryCodeController.text = '${data1.countryCode}';
            numberLimit = int.parse('${data1.phoneNumberLength}');
            prefs.setString('app_currency', '${data1.currencySign}');
            prefs.setString('app_referaltext', '${data1.refertext}');
            prefs.setString('app_name', '${data1.appName}');
            prefs.setString('country_code', '${data1.countryCode}');
            prefs.setString('numberlimit', '$numberLimit');
            prefs.setInt('last_loc', int.parse('${data1.lastLoc}'));
            prefs.setString('wallet_credits', '${data1.userWallet}');
            prefs.setString('imagebaseurl', '${data1.imageUrl}');
            getImageBaseUrl();
            showProgress = false;
          });
        } else {
          setState(() {
            showProgress = false;
          });
        }
      } else {
        setState(() {
          showProgress = false;
        });
      }
    }).catchError((e) {
      setState(() {
        showProgress = false;
      });
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom!=0;
    return SafeArea(
      top: true,
      bottom: true,
      right: false,
      left: false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: (appInfoModeld!=null)?Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            (!isKeyboardOpen)?Expanded(
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/loginImage.jpg',width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () async{
                        SharedPreferences.getInstance().then((value){
                          value.setBool('islogin', false);
                          value.setBool('skip', true);
                          Navigator.of(context).pushNamedAndRemoveUntil(PageRoutes.homePage, (Route<dynamic> route) => false);
                        });
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Skip',style: TextStyle(
                              color: kMainTextColor,
                              fontSize: 17
                            ),),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded,size:15,color: kMainTextColor,)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ):SizedBox.shrink(),
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Text(locale.hellol,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: kMainTextColor,
                          fontSize: 20)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, left: 20, right: 20),
                  child: Text(locale.hellol2,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: kMainTextColor, fontSize: 15)),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 5, right: 20, left: 20),
                  child: Text(locale.mobilenuml,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: kMainTextColor, fontSize: 15)),
                ),
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: kButtonBorderColor, width: 1)),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Container(
                        height: 52,
                        color: kButtonBorderColor.withOpacity(0.5),
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        margin: const EdgeInsets.only(right: 5),
                        child: Text(appInfoModeld!=null?'+${appInfoModeld.countryCode}':'--',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: kMainTextColor, fontSize: 15)),
                      ),
                      Expanded(
                        child: TextFormField(
                          controller: phoneNumberController,
                          readOnly: showProgress,
                          autofocus: false,
                          maxLength: numberLimit,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide:
                                    BorderSide(color: kTransparentColor),
                              ),
                              counterText: '',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide:
                                    BorderSide(color: kTransparentColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide:
                                    BorderSide(color: kTransparentColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide:
                                    BorderSide(color: kTransparentColor),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(0),
                                borderSide:
                                    BorderSide(color: kTransparentColor),
                              ),
                              hintText: "Enter your mobile number",
                              labelStyle: TextStyle(
                                  color: kLightTextColor, fontSize: 15),
                              suffixIcon: (isNumberOk)?Icon(Icons.done,
                                  size: 25.0, color: kMainColor):SizedBox.shrink(),
                              // prefixText: '+91',
                              // prefixIcon: Text('+91',style: TextStyle(
                              // color: kMainColor,
                              // fontSize: 14
                              // )
                              // ),
                              contentPadding: const EdgeInsets.all(0)
                          ),
                          onChanged: (value){
                            if(phoneNumberController.text.length==numberLimit){
                              setState(() {
                                isNumberOk = true;
                              });
                            }else{
                              setState(() {
                                isNumberOk = false;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: (showProgress)?Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(strokeWidth: 1,color : kMainColor,),
                  ):MaterialButton(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    onPressed: () {
                      if (!showProgress) {
                        setState(() {
                          showProgress = true;
                        });
                        if (phoneNumberController.text != null &&
                            phoneNumberController.text.length == numberLimit) {
                          hitLoginUrl('${phoneNumberController.text}', '', 'otp',
                              context);
                        } else {
                          Toast.show(locale.incorectMobileNumber, context,gravity: Toast.CENTER,duration: Toast.LENGTH_SHORT);
                          setState(() {
                            showProgress = false;
                          });
                        }
                      }
                      // else{
                      //   setState(() {
                      //     showProgress = false;
                      //   });
                      // }
                    },
                    color: kMainColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        locale.Continuel1,
                        style: TextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.6),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(locale.Continuel2,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: kLightTextColor,
                            fontSize: 15)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          if (!showProgress) {
                            setState(() {
                              showProgress = true;
                            });
                            _handleSignIn(context);
                          }
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/google_logo.png',
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(locale.googlel,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 15)),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        splashColor: kWhiteColor,
                        color: kWhiteColor,
                        highlightColor: kMainColor,
                        minWidth: 150,
                        height: 40,
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (!showProgress) {
                            setState(() {
                              showProgress = true;
                            });
                            _login(context);
                          }
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/fb.png',
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(locale.facebookl,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 15)),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        splashColor: kWhiteColor,
                        color: kWhiteColor,
                        highlightColor: kMainColor,
                        minWidth: 150,
                        height: 40,
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: Platform.isIOS,
                  child: SignInWithAppleButton(
                    onPressed: () {
                      if (!showProgress) {
                        setState(() {
                          showProgress = true;
                        });
                        signInWithApple().then((value){
                          UserCredential uC = value;
                          if(uC!=null){
                            var uName = uC.additionalUserInfo.username;
                            var uId = uC.additionalUserInfo.profile['sub'];
                            var eId = uC.additionalUserInfo.profile['email'];
                            print('$uName');
                            print(uId);
                            print(eId);
                            socialLogin(
                                'apple',
                                '',
                                '',
                                context,
                                uName ?? '',
                                (eId != null && eId.toString().isNotEmpty)
                                    ? eId
                                    : '',uId);
                          }else{
                            setState(() {
                              showProgress = false;
                            });
                          }
                        }).catchError((e){
                          print(e);
                          setState(() {
                            showProgress = false;
                          });
                        });
                      }
                    },
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: (){
                        if(!showProgress){
                          Navigator.pushNamed(context, PageRoutes.signUp, arguments: {
                            'user_phone': '${phoneNumberController.text}',
                            'numberlimit': numberLimit,
                            'appinfo': appInfoModeld,
                          });
                        }
                      },
                      behavior: HitTestBehavior.opaque,
                      child: RichText(
                        text: TextSpan(
                          text: locale.login1,
                          children: [
                            TextSpan(
                                text: ' ${locale.login2}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: kMainColor,
                                    fontSize: 15))
                          ],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kMainTextColor,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(
                  thickness: 10,
                  height: 10,
                  color: kWhiteColor,
                )
              ],
            ))
          ],
        ):const Align(
          widthFactor: 40,
          heightFactor: 40,
          child: CircularProgressIndicator(strokeWidth: 1,),
        ),
      ),
    );
  }

  String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<UserCredential> signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
      webAuthenticationOptions: WebAuthenticationOptions(
            clientId: 'com.thegroceryguys.usersigin',
            redirectUri: Uri.parse('https://thegroceryguys-68e6b.firebaseapp.com/__/auth/handler'))
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
      accessToken: nonce
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  void _handleSignIn(BuildContext contextd) async {
    _googleSignIn.isSignedIn().then((value) async {
      // print('${value}');

      if (value) {
        if (_googleSignIn.currentUser != null) {
          socialLogin('google', '${_googleSignIn.currentUser.email}', '',
              contextd, _googleSignIn.currentUser.displayName, '','');
        } else {
          _googleSignIn.signOut().then((value) async {
            await _googleSignIn.signIn().then((value) {
              var email = value.email;
              var nameg = value.displayName;
              socialLogin('google', '$email', '', contextd, nameg, '','');
              // print('${email} - ${value.id}');
            }).catchError((e) {
              setState(() {
                showProgress = false;
              });
            });
          }).catchError((e) {
            setState(() {
              showProgress = false;
            });
          });
        }
      } else {
        try {
          await _googleSignIn.signIn().then((value) {
            var email = value.email;
            var nameg = value.displayName;
            socialLogin('google', '$email', '', contextd, nameg, '','');
            // print('${email} - ${value.id}');
          });
        } catch (error) {
          setState(() {
            showProgress = false;
          });
          print(error);
        }
      }
    }).catchError((e) {
      setState(() {
        showProgress = false;
      });
    });
  }

  void socialLogin(dynamic loginType, dynamic email, dynamic fb_id,
      BuildContext contextd, dynamic userNameFb, dynamic fbmailid,dynamic appleID) async {
    print('$loginType - $appleID');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) {
      var client = Client();
      client.post(socialLoginUri, body: {
        'type': '$loginType',
        'user_email': '$email',
        'email_id': '$fbmailid',
        'facebook_id': '$fb_id',
        'apple_id': '$appleID',
        'device_id': '$token',
      }).then((value) {
        print('${value.statusCode} - ${value.body}');
        var jsData = jsonDecode(value.body);
        SignInModel signInData = SignInModel.fromJson(jsData);
        if ('${signInData.status}' == '1') {
          var userId = int.parse('${signInData.data.id}');
          prefs.setInt("user_id", userId);
          prefs.setString("user_name", '${signInData.data.name}');
          prefs.setString("user_email", '${signInData.data.email}');
          prefs.setString("user_image", '${signInData.data.userImage}');
          prefs.setString("user_phone", '${signInData.data.userPhone}');
          prefs.setString("user_password", '${signInData.data.password}');
          prefs.setString("wallet_credits", '${signInData.data.wallet}');
          prefs.setString("user_city", '${signInData.data.userCity}');
          prefs.setString("user_area", '${signInData.data.userArea}');
          prefs.setString("block", '${signInData.data.block}');
          prefs.setString("app_update", '${signInData.data.appUpdate}');
          prefs.setString("reg_date", '${signInData.data.regDate}');
          prefs.setBool("phoneverifed", true);
          prefs.setBool("islogin", true);
          prefs.setString("refferal_code", '${signInData.data.referralCode}');
          prefs.setString("reward", '${signInData.data.rewards}');
          prefs.setString("accesstoken", '${signInData.token}');
          Navigator.pushNamedAndRemoveUntil(
              context, PageRoutes.homePage, (route) => false);
        } else {
          if (loginType == 'google') {
            Navigator.pushNamed(contextd, PageRoutes.signUp, arguments: {
              'user_email': '$email',
              'u_name': '$userNameFb',
              'numberlimit': numberLimit,
              'appinfo': appInfoModeld,
            });
          } if (loginType == 'apple') {
            Navigator.pushNamed(contextd, PageRoutes.signUp, arguments: {
              'user_email': '$fbmailid',
              'u_name': '$userNameFb',
              'numberlimit': numberLimit,
              'appinfo': appInfoModeld,
              'apple_id': '$appleID',
              'logintype': '$loginType',
            });
          } else {
            Navigator.pushNamed(contextd, PageRoutes.signUp, arguments: {
              'fb_id': '$fb_id',
              'user_email': '$fbmailid',
              'u_name': '$userNameFb',
              'numberlimit': numberLimit,
              'appinfo': appInfoModeld,
            });
          }
        }
        setState(() {
          showProgress = false;
        });
      }).catchError((e) {
        setState(() {
          showProgress = false;
        });
        print(e);
      });
    } else {
      if (count == 0) {
        setState(() {
          count = 1;
        });
        messaging.getToken().then((value) {
          setState(() {
            token = value;
            socialLogin(
                loginType, email, fb_id, contextd, userNameFb, fbmailid,appleID);
          });
        }).catchError((e) {
          setState(() {
            showProgress = false;
          });
        });
      } else {
        setState(() {
          showProgress = false;
        });
      }
    }
  }

  void _login(BuildContext contextt) async {
    await facebookSignIn.logIn(['email']).then((result) {
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          final FacebookAccessToken accessToken = result.accessToken;
          hitgraphResponse(accessToken, contextt);
          break;
        case FacebookLoginStatus.cancelledByUser:
          setState(() {
            showProgress = false;
          });
          break;
        case FacebookLoginStatus.error:
          setState(() {
            showProgress = false;
          });
          break;
      }
    }).catchError((e) {
      setState(() {
        showProgress = false;
      });
      print(e);
    });
  }

  void hitgraphResponse(
      FacebookAccessToken accessToken, BuildContext contextt) async {
    var http = Client();
    http
        .get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}'))
        .then((graphResponse) {
      final profile = jsonDecode(graphResponse.body);
      print(profile);
      print(profile['first_name']);
      print(profile['last_name']);
      print(profile['email']);
      print(profile['id']);
      socialLogin(
          'facebook',
          '',
          '${profile['id']}',
          contextt,
          profile['name'],
          (profile['email'] != null &&
                  profile['email'].toString().length > 0 &&
                  '${profile['email']}'.toUpperCase() != 'NULL')
              ? profile['email']
              : '','');
    }).catchError((e) {
      print(e);
      setState(() {
        showProgress = false;
      });
    });
  }

  void hitLoginUrl(dynamic user_phone, dynamic user_password, dynamic logintype,
      BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) {
      var http = Client();
      http.post(loginUri, body: {
        'user_phone': '$user_phone',
        'user_password': '$user_password',
        'device_id': '$token',
        'logintype': '$logintype',
      }).then((value) {
        print('sign - ${value.body}');
        if (value.statusCode == 200) {
          var jsData = jsonDecode(value.body);
          SignInModel signInData = SignInModel.fromJson(jsData);
          print('${signInData.toString()}');
          if ('${signInData.status}' == '0') {
            Toast.show(signInData.message, context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
            Navigator.pushNamed(context, PageRoutes.signUp, arguments: {
              'user_phone': '$user_phone',
              'numberlimit': numberLimit,
              'appinfo': appInfoModeld,
            });
          } else if ('${signInData.status}' == '1') {
            var userId = int.parse('${signInData.data.id}');
            prefs.setInt("user_id", userId);
            prefs.setString("user_name", '${signInData.data.name}');
            prefs.setString("user_email", '${signInData.data.email}');
            prefs.setString("user_image", '${signInData.data.userImage}');
            prefs.setString("user_phone", '${signInData.data.userPhone}');
            prefs.setString("user_password", '${signInData.data.password}');
            prefs.setString("wallet_credits", '${signInData.data.wallet}');
            prefs.setString("user_city", '${signInData.data.userCity}');
            prefs.setString("user_area", '${signInData.data.userArea}');
            prefs.setString("city_name", '${signInData.data.cityName}');
            prefs.setString("society_name", '${signInData.data.societyName}');
            prefs.setString("block", '${signInData.data.block}');
            prefs.setString("app_update", '${signInData.data.appUpdate}');
            prefs.setString("reg_date", '${signInData.data.regDate}');
            prefs.setBool("phoneverifed", true);
            prefs.setBool("islogin", true);
            prefs.setString("refferal_code", '${signInData.data.referralCode}');
            prefs.setString("reward", '${signInData.data.rewards}');
            prefs.setString("accesstoken", '${signInData.token}');
            Navigator.pushNamedAndRemoveUntil(
                context, PageRoutes.homePage, (route) => false);
            // Navigator.popAndPushNamed(context, PageRoutes.home);
          } else if ('${signInData.status}' == '2') {
            Navigator.pushNamed(context, PageRoutes.verification, arguments: {
              'token': '$token',
              'user_phone': '$user_phone',
              'firebase': '${appInfoModeld.firebase}',
              'country_code': '${appInfoModeld.countryCode}',
              'activity': 'login',
            });
          } else if ('${signInData.status}' == '3') {
            Navigator.pushNamed(context, PageRoutes.verification, arguments: {
              'token': '$token',
              'user_phone': '$user_phone',
              'firebase': '${appInfoModeld.firebase}',
              'country_code': '${appInfoModeld.countryCode}',
              'activity': 'login',
            });
          } else {
            Toast.show(signInData.message, context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
          }
        }
        setState(() {
          showProgress = false;
        });
      }).catchError((e) {
        setState(() {
          showProgress = false;
        });
        print(e);
      });
    } else {
      if (count == 0) {
        setState(() {
          count = 1;
        });
        messaging.getToken().then((value) {
          setState(() {
            token = value;
            hitLoginUrl(user_phone, user_password, logintype, context);
          });
        }).catchError((e) {
          setState(() {
            showProgress = false;
          });
        });
      } else {
        setState(() {
          showProgress = false;
        });
      }
    }
  }
}