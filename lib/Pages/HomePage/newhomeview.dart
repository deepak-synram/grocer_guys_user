import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slide_drawer/slide_drawer.dart';
import 'package:user/Components/constantfile.dart';
import 'package:user/Locale/locales.dart';
import 'package:user/Pages/AccountPage/account_page.dart';
import 'package:user/Pages/Checkout/my_orders.dart';
import 'package:user/Pages/HomePage/newhomep1.dart';
import 'package:user/Pages/Search/search_product.dart';
import 'package:user/Pages/locpage/locationpage.dart';
import 'package:user/Pages/wallet/new_wallet_ui.dart';
import 'package:user/Pages/your_basket.dart';
import 'package:user/Routes/routes.dart';
import 'package:user/Theme/colors.dart';
import 'package:user/baseurl/baseurlg.dart';
import 'package:user/beanmodel/appnotice/appnotice.dart';
import 'package:user/beanmodel/appnotice/notiproductbean.dart';
import 'package:user/beanmodel/banner/bannerdeatil.dart';
import 'package:user/beanmodel/cart/cartitembean.dart';
import 'package:user/beanmodel/category/categorymodel.dart';
import 'package:user/beanmodel/storefinder/storefinderbean.dart';
import 'package:user/constants.dart';
import 'package:user/providergrocery/appnoticeprovider.dart';
import 'package:user/providergrocery/benprovider/toporbottombean.dart';
import 'package:user/providergrocery/bottomnavigationnavigator.dart';
import 'package:user/providergrocery/cartcountprovider.dart';
import 'package:user/providergrocery/cartlistprovider.dart';
import 'package:user/providergrocery/categoryprovider.dart';
import 'package:user/providergrocery/locationemiter.dart';
import 'package:user/providergrocery/locemittermodel.dart';
import 'package:user/providergrocery/profileprovider.dart';
import 'package:user/providergrocery/searchprovide.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   '1234', // id
//   'High Importance Notifications', // title
//   'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );
//
// Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
//   _showNotification(flutterLocalNotificationsPlugin,
//       '${message.notification.title}', '${message.notification.body}');
// }

class NewHomeView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewHomeViewState();
  }
}

class NewHomeViewState extends State<NewHomeView> with WidgetsBindingObserver {
  bool isEnteredFirst = false;
  bool islogin = true;
  var userName = '--';
  var http = Client();
  dynamic _scanBarcode;
  int _NotiCounter = 0;
  dynamic hintText = '--';
  String appbarTitle = '--';
  dynamic lat;
  dynamic lng;
  dynamic currentAddress = 'Tap/Set to change your location.';
  StoreFinderData storeFinderData;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<CartItemData> cartItemd = [];

  List<BannerDataModel> bannerList = [];
  Timer _timer;
  TextEditingController searchController = TextEditingController();

  bool isKeyboardOpen = false;
  bool _isInForeground = true;

  CartCountProvider cartCountP;

  ProfileProvider pRovider;
  AppNoitceProvider appNotice;

  String p = '123';

  void scanProductCode(BuildContext context) async {
    await FlutterBarcodeScanner.scanBarcode(
            "#ff6666", "Cancel", true, ScanMode.DEFAULT)
        .then((value) {
      if (value != null && value.length > 0 && value != '-1') {
        if (storeFinderData != null) {
          Navigator.pushNamed(context, PageRoutes.search, arguments: {
            'ean_code': value,
            'storedetails': storeFinderData,
          });
        }
        print('scancode - ${_scanBarcode}');
      }
    }).catchError((e) {});
  }

  List<CategoryDataModel> categoryList = [];
  LocationEmitter locEmitterP;
  CategoryProvider cateP;
  SearchProvider searchP;
  CartListProvider cartListPro;
  BottomNavigationEmitter navBottomProvider;

  @override
  void initState() {
    getImageBaseUrl();
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setFirebase();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _isInForeground = state == AppLifecycleState.resumed;
  }

  void setFirebase() async {
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
      iosPermission(messaging);
      var initializationSettingsAndroid =
          const AndroidInitializationSettings('icon');
      var initializationSettingsIOS = IOSInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
      var initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onSelectNotification: selectNotification);
      messaging.getToken().then((value) {
        debugPrint('token: $value');
      });
      FirebaseMessaging.instance
          .getInitialMessage()
          .then((RemoteMessage message) {
        // p = 'Publish Event I';
        // setState(() {});
        if (message != null) {
          if (message.data.containsKey('product_id')) {
            NotiProductBean beanNoti = NotiProductBean.fromJson(message.data);
            print(beanNoti.productId);
            if (beanNoti.productId != null) {
              Navigator.of(context).pushNamed(PageRoutes.notiProduct,
                  arguments: {'prodid': beanNoti.productId});
            }
          }
        }
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // p = 'Publish Event M';
        // setState(() {});
        RemoteNotification notification = message.notification;
        if (notification != null) {
          if (Platform.isAndroid) {
            if (message.data.containsKey('product_id')) {
              NotiProductBean beanNoti = NotiProductBean.fromJson(message.data);
              _showNotification(
                  flutterLocalNotificationsPlugin,
                  notification.title,
                  notification.body,
                  notification.hashCode,
                  beanNoti.toString());
            } else {
              _showNotification2(flutterLocalNotificationsPlugin,
                  notification.title, notification.body, notification.hashCode);
            }
          }
        }
      });
    }
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print('A new onMessageOpenedApp event was published!');
      // p = 'Publish Event P';
      // setState(() {});
      if (message.data.containsKey('product_id')) {
        if (message.data['product_id'] != null) {
          Navigator.of(context).pushNamed(PageRoutes.notiProduct,
              arguments: {'prodid': message.data['product_id']});
        }
      }
    });
    // FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  }

  var payload = '--';

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // p = 'Publish Event L';
    // setState(() {});
    if (payload != null) {
      var message = jsonDecode(payload);
      if (message['productId'] != null) {
        Navigator.of(context).pushNamed(PageRoutes.notiProduct,
            arguments: {'prodid': message['productId']});
      }
    }
    // // var message = jsonDecode('${payload}');
    // _showNotification(flutterLocalNotificationsPlugin, '${title}', '${body}');
  }

  Future selectNotification(String payloadd) async {
    // p = 'Publish Event S';
    // setState(() {});
    print('In Which $payloadd');
    var jsonD = jsonDecode(payloadd);
    if (jsonD['productId'] != null) {
      Navigator.of(context).pushNamed(PageRoutes.notiProduct,
          arguments: {'prodid': jsonD['productId']});
    }
  }

  void iosPermission(FirebaseMessaging firebaseMessaging) {
    if (Platform.isIOS) {
      firebaseMessaging.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void hitAppNotice() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    http.get(appNoticeUri, headers: {
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    }).then((value) {
      print('wert - ${value.body}');
      if (value.statusCode == 200) {
        AppNotice data1 = AppNotice.fromJson(jsonDecode(value.body));
        print('data - ${data1.toString()}');
        if ('${data1.status}' == '1') {
          appNotice.hitNotice(
              int.parse('${data1.data.status}'), '${data1.data.notice}');
        }
      }
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    if (!isEnteredFirst) {
      isEnteredFirst = true;
      locEmitterP = BlocProvider.of<LocationEmitter>(context);
      cateP = BlocProvider.of<CategoryProvider>(context);
      searchP = BlocProvider.of<SearchProvider>(context);
      cartListPro = BlocProvider.of<CartListProvider>(context);
      cartCountP = BlocProvider.of<CartCountProvider>(context);
      navBottomProvider = BlocProvider.of<BottomNavigationEmitter>(context);
      pRovider = BlocProvider.of<ProfileProvider>(context);
      appNotice = BlocProvider.of<AppNoitceProvider>(context);
      searchController.addListener(() {
        if (isKeyboardOpen) {
          if (searchController.text.length > 0 && storeFinderData != null) {
            searchP.hitSearchData(searchController.text, storeFinderData);
          } else {
            searchP.hitSearchData('', storeFinderData);
          }
        }
      });
      hitAppNotice();
      if (locEmitterP.state != null &&
          locEmitterP.state.lat != null &&
          locEmitterP.state.lat > 0.0 &&
          locEmitterP.state.lng != null &&
          locEmitterP.state.lng > 0.0) {
        print('in this');
        locEmitterP.getStoreId(locEmitterP.state);
      } else {
        print('in that');
        locEmitterP.hitLocEmitterInitial();
      }
      navBottomProvider.hitBottomNavigation(
          0, appbarTitle, '${locale.searchOnGoGrocer}$appname');
      getUserPrefs();
      pRovider.hitCounter();
    }

    return WillPopScope(
      onWillPop: () async {
        if (navBottomProvider.state != null &&
            navBottomProvider.state.navigation == 0) {
          return true;
        } else {
          navBottomProvider.hitBottomNavigation(
              0, appbarTitle, '${locale.searchOnGoGrocer}$appname');
          return false;
        }
      },
      child: SafeArea(
        top: true,
        bottom: true,
        child: BlocBuilder<BottomNavigationEmitter, TopAndBottomTitleCount>(
          builder: (context, bottonNavigator) {
            Constants.selectedInd = bottonNavigator.navigation;
            appbarTitle = bottonNavigator.apptitle;
            hintText = bottonNavigator.searchTitle;
            return Scaffold(
              key: _scaffoldKey,
              backgroundColor: const Color(0xfff8f8f8),
              // drawerScrimColor: kTransparentColor,
              // drawer: (Constants.selectedInd == 0)
              //     ? buildDrawer(context, userName, islogin, onHit: () {
              //         SharedPreferences.getInstance().then((pref) {
              //           pref.clear().then((value) {
              //             Navigator.of(context).pushNamedAndRemoveUntil(
              //                 PageRoutes.signInRoot,
              //                 (Route<dynamic> route) => false);
              //           });
              //         });
              //       })
              //     : null,
              appBar: Constants.selectedInd == 3
                  ? const PreferredSize(
                      preferredSize: Size(0, 0),
                      child: SizedBox.shrink(),
                    )
                  : PreferredSize(
                      preferredSize: Size(
                          MediaQuery.of(context).size.width,
                          (Constants.selectedInd == 0 ||
                                  Constants.selectedInd == 1)
                              ? 120
                              : 60),
                      child: Container(
                        color: const Color(0xff022e2b),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              visible: (Constants.selectedInd == 0),
                              child: AppBar(
                                backgroundColor: kMainColor,
                                systemOverlayStyle: SystemUiOverlayStyle(
                                  // Status bar color
                                  statusBarColor: kMainColor,
                                ),
                                automaticallyImplyLeading: false,
                                centerTitle: false,
                                // bottom: PreferredSize(
                                //   preferredSize: Size(
                                //       MediaQuery.of(context).size.width,
                                //       (Constants.selectedInd == 0 || Constants.selectedInd == 1)
                                //           ? 60
                                //           : 30),
                                //   child: Row(children: [
                                //     IconButton(
                                //         onPressed: () {
                                //           _scaffoldKey.currentState.openDrawer();
                                //         },
                                //         icon: Image.asset('menu-icon.png')),
                                //     TextFormField(
                                //       readOnly: false,
                                //       autofocus: false,
                                //       controller: searchController,
                                //       style: Theme.of(context)
                                //           .textTheme
                                //           .headline6
                                //           .copyWith(
                                //               color: kMainTextColor, fontSize: 18),
                                //       decoration: InputDecoration(
                                //           hintText: hintText,
                                //           hintStyle:
                                //               Theme.of(context).textTheme.subtitle2,
                                //           contentPadding:
                                //               EdgeInsets.symmetric(vertical: 10),
                                //           prefixIcon: Icon(
                                //             Icons.search,
                                //             color: kIconColor,
                                //           ),
                                //           focusColor: kMainTextColor,
                                //           border: OutlineInputBorder(
                                //               borderRadius: BorderRadius.circular(10),
                                //               borderSide: BorderSide.none),
                                //           enabledBorder: OutlineInputBorder(
                                //               borderRadius: BorderRadius.circular(10),
                                //               borderSide: BorderSide.none),
                                //           errorBorder: OutlineInputBorder(
                                //               borderRadius: BorderRadius.circular(10),
                                //               borderSide: BorderSide.none),
                                //           focusedBorder: OutlineInputBorder(
                                //               borderRadius: BorderRadius.circular(10),
                                //               borderSide: BorderSide.none)),
                                //     ),
                                //   ]),
                                // ),
                                title: BlocBuilder<LocationEmitter,
                                        LocEmitterModel>(
                                    builder: (context, locModel) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Dhavil Shah',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white),
                                            ),
                                            MaterialButton(
                                              onPressed: () {
                                                // locEmitterP.hitLocEmitter(LocEmitterModel(0.0,0.0,'Searching your location',true,null));
                                                var latdi = 0.0;
                                                var lngdi = 0.0;
                                                if (lat != null &&
                                                    lng != null) {
                                                  latdi = lat;
                                                  lngdi = lng;
                                                }
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return LocationPage(
                                                      latdi, lngdi);
                                                }));
                                              },
                                              splashColor: kWhiteColor,
                                              color: Colors.transparent,
                                              child: Row(
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                // crossAxisAlignment:
                                                //     CrossAxisAlignment.center,
                                                // runSpacing: 0.0,
                                                // spacing: 0.0,
                                                // runAlignment: WrapAlignment.center,
                                                // alignment: WrapAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.location_on,
                                                    color: Colors.yellow,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: 1,
                                                  ),
                                                  SizedBox(
                                                    width: 250,
                                                    child: Text(
                                                      locModel.address,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      // textAlign: TextAlign.center,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              elevation: 0,
                                              padding: const EdgeInsets.all(0),
                                              minWidth: 0,
                                              height: 20,
                                              materialTapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              focusColor: kButtonBorderColor
                                                  .withOpacity(0.8),
                                            ),
                                          ]),
                                      // Text(
                                      //   (locModel.storeFinderData != null &&
                                      //           locModel.storeFinderData
                                      //                   .store_opening_time !=
                                      //               null)
                                      //       ? '${locModel.storeFinderData.store_opening_time} AM - ${locModel.storeFinderData.store_closing_time} PM'
                                      //       : '00:00 AM - 00:00 PM',
                                      //   style: TextStyle(
                                      //       color: kMainTextColor, fontSize: 12),
                                      // )
                                    ],
                                  );
                                }),
                                actions: [
                                  Visibility(
                                    // visible: (storeFinderData != null &&
                                    //     storeFinderData.store_id != null),
                                    visible: true,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: InkWell(
                                        splashColor: kTransparentColor,
                                        highlightColor: kTransparentColor,
                                        onTap: () => Navigator.pushNamed(
                                          context,
                                          PageRoutes.notification,
                                        ),
                                        child: Image.asset(
                                          'assets/bell-icon.png',
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: (Constants.selectedInd == 1 ||
                                  Constants.selectedInd == 3),
                              child: AppBar(
                                backgroundColor: kMainColor,
                                title: Text(
                                  appbarTitle,
                                  style: TextStyle(
                                      color: kMainTextColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                automaticallyImplyLeading: true,
                                centerTitle: true,
                                leading: GestureDetector(
                                  onTap: () {
                                    navBottomProvider.hitBottomNavigation(
                                        0,
                                        appbarTitle,
                                        '${locale.searchOnGoGrocer}$appname');
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: const Icon(Icons.arrow_back_ios_sharp),
                                ),
                                actions: [
                                  Visibility(
                                    // visible: (storeFinderData != null &&
                                    //     storeFinderData.store_id != null),
                                    visible: true,
                                    child: IconButton(
                                      icon: const ImageIcon(AssetImage(
                                        'assets/scanner_logo.png',
                                      )),
                                      onPressed: () async {
                                        scanProductCode(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Visibility(
                            //   visible: (Constants.selectedInd == 1),
                            //   child: Row(
                            //     children: [
                            //       Expanded(
                            //           child: Container(
                            //         margin: const EdgeInsets.symmetric(
                            //             horizontal: 20),
                            //         decoration: BoxDecoration(
                            //             color: kWhiteColor,
                            //             borderRadius: BorderRadius.circular(10),
                            //             border: Border.all(
                            //                 color: const Color(0xfff8f8f8),
                            //                 width: 1),
                            //             boxShadow: const [
                            //               BoxShadow(
                            //                   color: Color(0xfff8f8f8),
                            //                   offset: Offset(-1, -1),
                            //                   blurRadius: 5),
                            //               BoxShadow(
                            //                   color: Color(0xfff8f8f8),
                            //                   offset: Offset(1, 1),
                            //                   blurRadius: 5)
                            //             ]),
                            //         child: TextFormField(
                            //           readOnly: (Constants.selectedInd != 1),
                            //           onTap: () {
                            //             categoryList = cateP.getCategoryList();
                            //           },
                            //           onChanged: (value) {
                            //             List<CategoryDataModel> chList =
                            //                 categoryList
                            //                     .where((element) => element
                            //                         .title
                            //                         .toString()
                            //                         .toLowerCase()
                            //                         .contains(
                            //                             value.toLowerCase()))
                            //                     .toList();
                            //             cateP.emitCategoryList(
                            //                 chList, storeFinderData);
                            //           },
                            //           autofocus: false,
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .headline6
                            //               .copyWith(
                            //                   color: kMainTextColor,
                            //                   fontSize: 18),
                            //           decoration: InputDecoration(
                            //               hintText: hintText,
                            //               hintStyle: Theme.of(context)
                            //                   .textTheme
                            //                   .subtitle2,
                            //               contentPadding:
                            //                   const EdgeInsets.symmetric(
                            //                 vertical: 10,
                            //               ),
                            //               prefixIcon: Icon(
                            //                 Icons.search,
                            //                 color: kIconColor,
                            //               ),
                            //               focusColor: kMainTextColor,
                            //               border: OutlineInputBorder(
                            //                   borderRadius:
                            //                       BorderRadius.circular(10),
                            //                   borderSide: BorderSide.none),
                            //               enabledBorder: OutlineInputBorder(
                            //                   borderRadius:
                            //                       BorderRadius.circular(10),
                            //                   borderSide: BorderSide.none),
                            //               errorBorder: OutlineInputBorder(
                            //                   borderRadius:
                            //                       BorderRadius.circular(10),
                            //                   borderSide: BorderSide.none),
                            //               focusedBorder: OutlineInputBorder(
                            //                   borderRadius:
                            //                       BorderRadius.circular(10),
                            //                   borderSide: BorderSide.none)),
                            //         ),
                            //       )),
                            //       Visibility(
                            //         visible: (Constants.selectedInd == 2),
                            //         child: Padding(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: 10),
                            //           child: Badge(
                            //             padding: const EdgeInsets.all(5),
                            //             position: const BadgePosition(
                            //                 end: -2.5, top: -5),
                            //             animationDuration:
                            //                 const Duration(milliseconds: 300),
                            //             animationType: BadgeAnimationType.slide,
                            //             badgeContent: Text(
                            //               _NotiCounter.toString(),
                            //               style: TextStyle(
                            //                   color: kWhiteColor, fontSize: 10),
                            //             ),
                            //             child: Icon(
                            //               Icons.filter_list_sharp,
                            //               color: kMainTextColor,
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            Visibility(
                              visible: (Constants.selectedInd == 0),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: Row(children: [
                                  IconButton(
                                    icon: Image.asset(
                                      'assets/menu-icon.png',
                                    ),
                                    iconSize: 40,
                                    onPressed: () {
                                      // _scaffoldKey.currentState.openDrawer();
                                      SlideDrawer?.of(context)?.toggle();
                                    },
                                  ),
                                  Expanded(
                                    child: BlocBuilder<LocationEmitter,
                                        LocEmitterModel>(
                                      builder: (context, locModel) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return SearchProduct(
                                                catP: cateP,
                                                locale: locale,
                                                locModel: locModel,
                                              );
                                            }));
                                          },
                                          child: Container(
                                            height: 40,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Color(0xfff8f8f8),
                                                    width: 1),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Color(0xfff8f8f8),
                                                  ),
                                                  BoxShadow(
                                                    color: Color(0xfff8f8f8),
                                                  )
                                                ]),
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Icon(
                                                    Icons.search,
                                                    color: kIconColor,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 2.0),
                                                  child: Text('$hintText',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .subtitle2),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ]),
                              ),
                            ),
                            // Visibility(
                            //   visible: (Constants.selectedInd == 2),
                            //   child: Row(
                            //     children: [
                            //       Expanded(
                            //           child: Container(
                            //         margin: const EdgeInsets.symmetric(
                            //             horizontal: 20),
                            //         decoration: BoxDecoration(
                            //             color: kWhiteColor,
                            //             borderRadius: BorderRadius.circular(10),
                            //             border: Border.all(
                            //                 color: Color(0xfff8f8f8), width: 1),
                            //             boxShadow: const [
                            //               BoxShadow(
                            //                   color: Color(0xfff8f8f8),
                            //                   offset: Offset(-1, -1),
                            //                   blurRadius: 5),
                            //               BoxShadow(
                            //                   color: Color(0xfff8f8f8),
                            //                   offset: Offset(1, 1),
                            //                   blurRadius: 5)
                            //             ]),
                            //         child: TextFormField(
                            //           readOnly: false,
                            //           autofocus: false,
                            //           controller: searchController,
                            //           style: Theme.of(context)
                            //               .textTheme
                            //               .headline6
                            //               .copyWith(
                            //                   color: kMainTextColor,
                            //                   fontSize: 18),
                            //           decoration: InputDecoration(
                            //               hintText: hintText,
                            //               hintStyle: Theme.of(context)
                            //                   .textTheme
                            //                   .subtitle2,
                            //               contentPadding: EdgeInsets.symmetric(
                            //                   vertical: 10),
                            //               prefixIcon: Icon(
                            //                 Icons.search,
                            //                 color: kIconColor,
                            //               ),
                            //               focusColor: kMainTextColor,
                            //               border: OutlineInputBorder(
                            //                   borderRadius:
                            //                       BorderRadius.circular(10),
                            //                   borderSide: BorderSide.none),
                            //               enabledBorder: OutlineInputBorder(
                            //                   borderRadius:
                            //                       BorderRadius.circular(10),
                            //                   borderSide: BorderSide.none),
                            //               errorBorder: OutlineInputBorder(
                            //                   borderRadius:
                            //                       BorderRadius.circular(10),
                            //                   borderSide: BorderSide.none),
                            //               focusedBorder: OutlineInputBorder(
                            //                   borderRadius:
                            //                       BorderRadius.circular(10),
                            //                   borderSide: BorderSide.none)),
                            //         ),
                            //       )),
                            //       Visibility(
                            //         // visible: (Constants.selectedInd == 2),
                            //         visible: false,
                            //         child: Padding(
                            //           padding: const EdgeInsets.symmetric(
                            //               horizontal: 10),
                            //           child: Badge(
                            //             padding: const EdgeInsets.all(5),
                            //             position: const BadgePosition(
                            //                 end: -2.5, top: -5),
                            //             animationDuration:
                            //                 const Duration(milliseconds: 300),
                            //             animationType: BadgeAnimationType.slide,
                            //             badgeContent: Text(
                            //               _NotiCounter.toString(),
                            //               style: TextStyle(
                            //                   color: kWhiteColor, fontSize: 10),
                            //             ),
                            //             child: Icon(
                            //               Icons.filter_list_sharp,
                            //               color: kMainTextColor,
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            Visibility(
                              // visible: (Constants.selectedInd == 2),
                              visible: false,
                              child: Container(
                                height: 52,
                                alignment: Alignment.centerLeft,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 7),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          border: Border.all(
                                              color: kButtonBorderColor,
                                              width: 2)),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Category",
                                            style: TextStyle(
                                                color: kMainTextColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          const Icon(
                                            Icons.close,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              extendBody: true,
              body: BlocBuilder<CartListProvider, List<CartItemData>>(
                  builder: (context, cartList) {
                cartItemd = List.from(cartList);
                // print('indi d - $Constants.selectedInd ${bottonNavigator.navigation}');
                return IndexedStack(
                  index: bottonNavigator.navigation,
                  children: [
                    BlocBuilder<LocationEmitter, LocEmitterModel>(
                        builder: (context, locModel) {
                      storeFinderData = locModel.storeFinderData;
                      if (locModel != null) {
                        if (locModel.isSearching) {
                          return buildSingleScreenView(context);
                        } else {
                          if (locModel.lat > 0.0 &&
                              locModel.lng > 0.0 &&
                              locModel.storeFinderData != null &&
                              locModel.storeFinderData.store_id != null) {
                            currentAddress = locModel.address;
                            return NewHomeView1(locModel, cartItemd);
                          } else {
                            return const Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'No Product Found at your location or we are fetching your product by your nearest store.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(letterSpacing: 1.5),
                                ),
                              ),
                            );
                          }
                        }
                      } else {
                        return const Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'null value',
                              textAlign: TextAlign.center,
                              style: TextStyle(letterSpacing: 1.5),
                            ),
                          ),
                        );
                      }
                    }),
                    // NewCategoryScreen(),
                    // NewSearchScreen(),
                    MyOrders(
                      fromHomePage: true,
                    ),
                    NewWalletUI(),
                    AccountPage(navBottomProvider: navBottomProvider),

                    // AccountData(),
                  ],
                );
              }),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              floatingActionButton: Transform.translate(
                offset: const Offset(0.0, 10.0),
                child: SizedBox(
                  height: 70.0,
                  width: 70.0,
                  child: FittedBox(
                    child: FloatingActionButton(
                      backgroundColor: kTransparentColor,
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => YourBasket(),
                        ),
                      ),
                      child: Image.asset(
                        'assets/ic_floating.png',
                      ),
                    ),
                  ),
                ),
              ),

              bottomNavigationBar: BottomAppBar(
                notchMargin: 30.0,
                // clipBehavior: Clip.antiAlias,
                shape: const CircularNotchedRectangle(),
                color: kMainColor,
                child: SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            navBottomProvider.hitBottomNavigation(
                                0,
                                appbarTitle,
                                '${locale.searchOnGoGrocer}$appname');
                            // hintText = ;
                            // setState(() {
                            //   Constants.selectedInd = 0;
                            //
                            // });
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(
                              //   Icons.home,
                              //   color: (Constants.selectedInd == 0)
                              //       ? kMainColor
                              //       : kMainTextColor,
                              // ),
                              Image.asset(
                                'assets/ic_home.png',
                                width: 20,
                                height: 20,
                                color: (Constants.selectedInd == 0)
                                    ? kWhiteColor
                                    : kNavigationButtonColor,
                              ),
                              Text(
                                "Home",
                                style: TextStyle(
                                    color: (Constants.selectedInd == 0)
                                        ? kWhiteColor
                                        : kNavigationButtonColor),
                              )
                            ],
                          ),
                        ),

                        // Expanded(
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       if (Constants.selectedInd != 1) {
                        //         navBottomProvider.hitBottomNavigation(
                        //             1,
                        //             'Category',
                        //             'what are you looking for (e.g. mango, onion)');
                        //         if (storeFinderData != null) {
                        //           if (!cateP.state.isSearching) {
                        //             cateP.hitBannerDetails(
                        //                 '${storeFinderData.store_id}',
                        //                 storeFinderData);
                        //           } else {
                        //             Toast.show('currently in progress', context,
                        //                 duration: Toast.LENGTH_SHORT,
                        //                 gravity: Toast.CENTER);
                        //           }
                        //         }
                        //       }
                        //     },
                        //     behavior: HitTestBehavior.opaque,
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Icon(
                        //           Icons.category,
                        //           color: (Constants.selectedInd == 1)
                        //               ? kMainColor
                        //               : kMainTextColor,
                        //         ),
                        //         Text(
                        //           "Categories",
                        //           style: TextStyle(
                        //               color: (Constants.selectedInd == 1)
                        //                   ? kMainColor
                        //                   : kMainTextColor),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        GestureDetector(
                          onTap: () {
                            // searchP.emitSearchNull();
                            navBottomProvider.hitBottomNavigation(
                                1,
                                "My Orders",
                                '${locale.searchOnGoGrocer}$appname');
                            // hintText = ;
                            // setState(() {
                            //   Constants.selectedInd = 2;
                            // });
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(
                              //   Icons.search,
                              //   color: (Constants.selectedInd == 2)
                              //       ? kMainColor
                              //       : kMainTextColor,
                              // ),
                              Image.asset(
                                'assets/ic_order.png',
                                width: 20,
                                height: 20,
                                color: (Constants.selectedInd == 1)
                                    ? kWhiteColor
                                    : kNavigationButtonColor,
                              ),

                              Text(
                                "Order",
                                style: TextStyle(
                                    color: (Constants.selectedInd == 1)
                                        ? kWhiteColor
                                        : kNavigationButtonColor),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),

                        GestureDetector(
                          onTap: () {
                            // Navigator.of(context)
                            //     .pushNamed(PageRoutes.yourbasket)
                            //     .then((value) {
                            //   navBottomProvider.hitBottomNavigation(
                            //       0,
                            //       appbarTitle,
                            //       '${locale.searchOnGoGrocer}$appname');
                            //   // hintText = ;
                            // });
                            navBottomProvider.hitBottomNavigation(
                                2, 'My Wallets', hintText);

                            // setState(() {
                            //   // Constants.selectedInd = 0;
                            // });
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BlocBuilder<CartCountProvider, int>(
                                  builder: (context, cartCount) {
                                // return Badge(
                                //   padding: const EdgeInsets.all(5),
                                //   animationDuration:
                                //       const Duration(milliseconds: 300),
                                //   animationType: BadgeAnimationType.slide,
                                //   badgeContent: Text(
                                //     cartCount.toString(),
                                //     style: TextStyle(
                                //         color: kWhiteColor, fontSize: 10),
                                //   ),
                                //   child:
                                return Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Image.asset(
                                    'assets/ic_wallet.png',
                                    width: 20,
                                    height: 20,
                                    color: (Constants.selectedInd == 2)
                                        ? kWhiteColor
                                        : kNavigationButtonColor,

                                    // Icon(
                                    //   Icons.shopping_basket,
                                    //   color: kMainTextColor,
                                    // ),
                                  ),
                                );
                              }),
                              Padding(
                                padding: const EdgeInsets.only(left: 30.0),
                                child: Text(
                                  "Wallet",
                                  style: TextStyle(
                                    color: (Constants.selectedInd == 2)
                                        ? kWhiteColor
                                        : kNavigationButtonColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // if (Constants.selectedInd != 0 &&
                            //     Constants.selectedInd != 1 &&
                            //     Constants.selectedInd != 2 &&
                            //     Constants.selectedInd != 3) {
                            //   cartCountP.hitCounter();
                            // }
                            navBottomProvider.hitBottomNavigation(
                                3, 'Account', hintText);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Icon(
                              //   Icons.account_box_outlined,
                              //   color: (Constants.selectedInd == 3)
                              //       ? kMainColor
                              //       : kMainTextColor,
                              // ),
                              Image.asset(
                                'assets/ic_account.png',
                                width: 20,
                                height: 20,
                                color: (Constants.selectedInd == 3)
                                    ? kWhiteColor
                                    : kNavigationButtonColor,
                              ),

                              Text(
                                "Account",
                                style: TextStyle(
                                    color: (Constants.selectedInd == 3)
                                        ? kWhiteColor
                                        : kNavigationButtonColor),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void getUserPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getBool('islogin') ?? false) {
        userName = prefs.getString('user_name');
        islogin = true;
      } else {
        userName = 'Hey User';
        islogin = false;
      }
    });
  }
}

Future<void> _showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    dynamic title,
    dynamic body,
    int idCode,
    dynamic data) async {
  final Int64List vibrationPattern = Int64List(4);
  vibrationPattern[0] = 0;
  vibrationPattern[1] = 1000;
  vibrationPattern[2] = 5000;
  vibrationPattern[3] = 2000;
  final AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('1234', 'Notify', 'Notify On Shopping',
          vibrationPattern: vibrationPattern,
          importance: Importance.max,
          priority: Priority.high,
          enableLights: true,
          enableVibration: true,
          icon: 'icon',
          playSound: true,
          ticker: 'message');
  const IOSNotificationDetails iOSPlatformChannelSpecifics =
      IOSNotificationDetails(presentSound: true);
  final NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin
      .show(idCode, '$title', '$body', platformChannelSpecifics, payload: data);
}

Future<void> _showNotification2(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    dynamic title,
    dynamic body,
    int idCode) async {
  final Int64List vibrationPattern = Int64List(4);
  vibrationPattern[0] = 0;
  vibrationPattern[1] = 1000;
  vibrationPattern[2] = 5000;
  vibrationPattern[3] = 2000;
  final AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('1234', 'Notify', 'Notify On Shopping',
          vibrationPattern: vibrationPattern,
          importance: Importance.max,
          priority: Priority.high,
          enableLights: true,
          enableVibration: true,
          icon: 'icon',
          playSound: true,
          ticker: 'message');
  const IOSNotificationDetails iOSPlatformChannelSpecifics =
      IOSNotificationDetails(presentSound: true);
  final NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iOSPlatformChannelSpecifics,
  );
  await flutterLocalNotificationsPlugin.show(
      idCode, '$title', '$body', platformChannelSpecifics);
}
