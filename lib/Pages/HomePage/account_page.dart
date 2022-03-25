import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:user/Locale/locales.dart';
import 'package:user/MyAccount/account_card.dart';
import 'package:user/Pages/Other/app_bar.dart';
import 'package:user/Routes/routes.dart';
import 'package:user/Theme/colors.dart';
import 'package:user/baseurl/baseurlg.dart';
import 'package:user/beanmodel/appinfo.dart';
import 'package:user/beanmodel/signinmodel.dart';
import 'package:user/providergrocery/locationemiter.dart';
import 'package:user/providergrocery/profileprovider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  static final FacebookLogin facebookSignIn = new FacebookLogin();
  GoogleSignIn _googleSignIn;
  bool showProgress = false;
  bool enteredFirst = false;
  int numberLimit = 10;
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

  bool valueNoti = true;
  bool isLogin = false;
  String userName = '--';
  String useremail = '--';
  String userMobileNumber = '--';
  String walletAmount = '--';
  String apCurrecny = '--';
  LocationEmitter locEmitterP;

  ProfileProvider pRovider;

  @override
  void initState() {
    super.initState();
    getSharedValue();
    hitAsyncInit();
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
      ],
    );
  }

  void hitAsyncInit() async {
    try {
      FirebaseApp app;
      List<FirebaseApp> firebase = Firebase.apps;
      for (FirebaseApp appd in firebase) {
        if (appd.name == 'TheGroceryGuys') {
          app = appd;
          break;
        }
      }
      if (app == null) {
        if (Platform.isIOS) {
          await Firebase.initializeApp(
            name: 'TheGroceryGuys',
            options: const FirebaseOptions(
                apiKey: 'AIzaSyCN5YHSeA-6rB4B4gApnjzAqffibeFD8WY',
                appId: '1:857676187722:ios:7735d516dcd902efb87eb3',
                messagingSenderId: '857676187722',
                projectId: 'thegroceryguys-68e6b'),
          );
        } else {
          await Firebase.initializeApp();
        }
      }
    } finally {
      messaging = FirebaseMessaging.instance;
      messaging.getToken().then((value) {
        token = value;
      });
    }
  }

  void getSharedValue() async {
    print('do');
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getBool('islogin')) {
        setState(() {
          isLogin = true;
          userName = prefs.getString('user_name');
          useremail = prefs.getString('user_email');
          userMobileNumber = prefs.getString('user_phone');
          walletAmount = prefs.getString('wallet_credits');
          apCurrecny = prefs.getString('app_currency');
        });
      } else {
        setState(() {
          isLogin = false;
          apCurrecny = prefs.getString('app_currency');
        });
      }
    });
  }

  void _handleSignIn(BuildContext contextd) async {
    _googleSignIn.isSignedIn().then((value) async {
      print('$value');

      if (value) {
        if (_googleSignIn.currentUser != null) {
          socialLogin('google', _googleSignIn.currentUser.email, '', contextd,
              _googleSignIn.currentUser.displayName, '');
        } else {
          _googleSignIn.signOut().then((value) async {
            await _googleSignIn.signIn().then((value) {
              var email = value.email;
              var nameg = value.displayName;
              socialLogin('google', email, '', contextd, nameg, '');
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
            socialLogin('google', email, '', contextd, nameg, '');
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
      BuildContext contextd, dynamic userNameFb, dynamic fbmailid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) {
      var client = Client();
      client.post(socialLoginUri, body: {
        'type': '$loginType',
        'user_email': '$email',
        'email_id': '$fbmailid',
        'facebook_id': '$fb_id',
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
                loginType, email, fb_id, contextd, userNameFb, fbmailid);
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
              : '');
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
          print(signInData.toString());
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

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    if (!enteredFirst) {
      locEmitterP = BlocProvider.of<LocationEmitter>(context);
      pRovider = BlocProvider.of<ProfileProvider>(context);
      enteredFirst = true;
      pRovider.hitCounter();
    }

    return Scaffold(
      appBar: const CustomAppBar(title: 'My Account'),
      body: BlocBuilder<ProfileProvider, AppInfoModel>(
        builder: (context, signModel) {
          if (signModel != null) {
            appInfoModeld = signModel;
            walletAmount = '${signModel.userWallet}';
            numberLimit = int.parse('${appInfoModeld.phoneNumberLength}');
          } else {
            getSharedValue();
          }

          return signModel != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: 140,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(35, 71, 69, 1.0),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: ListTile(
                                title: Text(
                                  userName,
                                  style: TextStyle(
                                    color: kWhiteColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
                                ),
                                //     Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     const SizedBox(height: 5),
                                //     Text(
                                //       userName,
                                //       style: TextStyle(
                                //         color: kWhiteColor,
                                //         fontWeight: FontWeight.w600,
                                //         fontSize: 16,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                isThreeLine: true,
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      useremail,
                                      style: TextStyle(
                                        color: kWhiteColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      userMobileNumber,
                                      style: TextStyle(
                                        color: kWhiteColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: InkWell(
                                  splashColor: kTransparentColor,
                                  highlightColor: kTransparentColor,
                                  onTap: () => Navigator.of(context)
                                      .pushNamed(PageRoutes.myaccount),
                                  child: Image.asset(
                                    'assets/Subscribe/ic_edit.png',
                                    height: 30,
                                    width: 30,
                                  ),
                                ),
                                leading:
                                    Image.asset('assets/logo_without_name.png'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 40.0,
                                right: 40.0,
                              ),
                              child: Material(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Container(
                                  height: 60,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: kWhiteColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // RichText(
                                        //   text: TextSpan(
                                        //     children: [
                                        //       WidgetSpan(
                                        //         child: Icon(
                                        //           Icons.location_on,
                                        //           color: kMainColor,
                                        //           size: 20,
                                        //         ),
                                        //       ),
                                        //       TextSpan(
                                        //         text: ' Location Location Location Location Location Location',

                                        //         style: TextStyle(
                                        //           fontWeight: FontWeight.w400,
                                        //           color: kMainColor,
                                        //           fontSize: 14,
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        Icon(
                                          Icons.location_on,
                                          color: kMainColor,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        Flexible(
                                          child: Text(
                                            'Akshay Nagar, 1st Block, 1st Cross, Rammurthy nagar, Ahmedabad-380015',
                                            maxLines: 2,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: kMainColor,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: kTransparentColor,
                                          highlightColor: kTransparentColor,
                                          onTap: () => Navigator.of(context)
                                              .pushNamed(PageRoutes.myaddress),
                                          child: Image.asset(
                                            'assets/Subscribe/ic_edit.png',
                                            height: 30,
                                            width: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        AccountCard(
                          image: 'assets/MyAccount/ic_orders.png',
                          title: ' My Order',
                          onClick: () => Navigator.of(context)
                              .pushNamed(PageRoutes.orderscreen),
                        ),
                        AccountCard(
                          image: 'assets/MyAccount/ic_subscription.png',
                          title: ' My Subscriptions',
                          onClick: () => Navigator.pushNamed(
                              context, PageRoutes.mySubscription),
                        ),
                        AccountCard(
                          image: 'assets/MyAccount/ic_wallet.png',
                          title: ' My Wallet',
                          price: '$apCurrecny $walletAmount',
                          onClick: () => Navigator.of(context)
                              .pushNamed(PageRoutes.walletscreen),
                        ),
                        const AccountCard(
                          image: 'assets/MyAccount/ic_rewards.png',
                          title: ' Rewards',
                        ),
                        AccountCard(
                          image: 'assets/MyAccount/ic_bell.png',
                          title: ' Notifications',
                          onClick: () => Navigator.pushNamed(
                              context, PageRoutes.notification),
                        ),
                        AccountCard(
                          image: 'assets/MyAccount/ic_address.png',
                          title: ' Manage Address',
                          onClick: () => Navigator.of(context)
                              .pushNamed(PageRoutes.myaddress),
                        ),
                        AccountCard(
                          image: 'assets/MyAccount/ic_info.png',
                          title: ' About Us',
                          onClick: () => Navigator.of(context)
                              .pushNamed(PageRoutes.aboutusscreen),
                        ),
                        AccountCard(
                          image: 'assets/MyAccount/ic_settings.png',
                          title: ' Settings',
                          onClick: () => Navigator.of(context)
                              .pushNamed(PageRoutes.settingsAccount),
                        ),
                      ],
                    ),
                  ),
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
