import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:slide_drawer/slide_drawer.dart';
import 'package:user/Locale/locales.dart';
import 'package:user/Routes/routes.dart';
import 'package:user/Theme/colors.dart';
import 'package:user/Theme/style.dart';
import 'package:user/constants.dart';
import 'package:user/language_cubit.dart';
import 'package:user/providergrocery/add2cartsnap.dart';
import 'package:user/providergrocery/appnoticeprovider.dart';
import 'package:user/providergrocery/bannerprovider.dart';
import 'package:user/providergrocery/bottomnavigationnavigator.dart';
import 'package:user/providergrocery/cartcountprovider.dart';
import 'package:user/providergrocery/cartlistprovider.dart';
import 'package:user/providergrocery/categoryprovider.dart';
import 'package:user/providergrocery/locationemiter.dart';
import 'package:user/providergrocery/pagesnap.dart';
import 'package:user/providergrocery/profileprovider.dart';
import 'package:user/providergrocery/searchprovide.dart';
import 'package:user/providergrocery/singleapiemiter.dart';
import 'package:user/providergrocery/trndlistemitter.dart';

import 'Pages/HomePage/newhomeview.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  Key slidingDrawer = const Key('trial');

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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: kMainColor,
    ));

    runApp(
      Phoenix(
          child: MultiBlocProvider(
        providers: [
          BlocProvider<AppNoitceProvider>(
            create: (context) => AppNoitceProvider(),
          ),
          BlocProvider<ImageSnapReview>(
            create: (context) => ImageSnapReview(),
          ),
          BlocProvider<LocationEmitter>(
            create: (context) => LocationEmitter(),
          ),
          BlocProvider<BottomNavigationEmitter>(
            create: (context) => BottomNavigationEmitter(),
          ),
          BlocProvider<BanerProvider>(
            create: (context) => BanerProvider(),
          ),
          BlocProvider<A2CartSnap>(
            create: (context) =>
                A2CartSnap(AddtoCartB(status: false, prodId: -1)),
          ),
          BlocProvider<CartListProvider>(
            create: (context) => CartListProvider(),
          ),
          BlocProvider<SingleApiEmitter>(
            create: (context) => SingleApiEmitter(),
          ),
          BlocProvider<SearchProvider>(
            create: (context) => SearchProvider(),
          ),
          BlocProvider<TopRecentNewDealProvider>(
            create: (context) => TopRecentNewDealProvider(),
          ),
          BlocProvider<CategoryProvider>(
            create: (context) => CategoryProvider(),
          ),
          BlocProvider<CartCountProvider>(
            create: (context) => CartCountProvider(),
          ),
          BlocProvider<TopRecentNewDealProvider>(
            create: (context) => TopRecentNewDealProvider(),
          ),
          BlocProvider<ProfileProvider>(
            create: (context) => ProfileProvider(),
          ),
          BlocProvider<PageSnapReview>(
            create: (context) => PageSnapReview(0),
          ),
          BlocProvider<LanguageCubit>(
            create: (context) => LanguageCubit(),
          ),
        ],
        child: BlocBuilder<LanguageCubit, Locale>(
          builder: (_, locale) {
            return MaterialApp(
                key: UniqueKey(),
                builder: (context, child) {
                  return child ?? const SizedBox.shrink();
                  // final MediaQueryData data = MediaQuery.of(context);
                  // return GestureDetector(
                  //   onTap: () {
                  //     FocusScope.of(context).requestFocus(FocusNode());
                  //   },
                  //   child: child,
                  // );
                },
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const [
                  Locale('en'),
                  Locale('ar'),
                  Locale('pt'),
                  Locale('fr'),
                  Locale('id'),
                  Locale('es'),
                ],
                locale: locale,
                theme: appTheme,
                // home: SignIn(),
                // initialRoute: PageRoutes.signInRoot,
                routes: PageRoutes().routes(),
                title: 'Grocer Guys',
                home: Builder(builder: (context) {
                  return SlideDrawer(
                    alignment: SlideDrawerAlignment.start,
                    backgroundColor: const Color(0xffffc339),
                    contentDrawer: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisAlignment: MainAxisAlignment.start,
                        textBaseline: TextBaseline.ideographic,
                        children: [
                          Builder(builder: (context) {
                            return IconButton(
                              padding: const EdgeInsets.all(0),
                              iconSize: 40,
                              onPressed: () {
                                SlideDrawer.of(context).toggle();
                              },
                              icon: Image.asset(
                                'assets/DrawerIcon/close-button.png',
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Hello, Dhvanil',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  // const SizedBox(width: 1),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          'Home:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        ),
                                        Text(
                                          'Some address which is',
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                          style: TextStyle(color: Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // const SizedBox(width: 3),
                              Image.asset(
                                'assets/DrawerIcon/pencil-icon.png',
                                height: 30,
                                width: 30,
                              ),
                            ],
                          ),
                          // ListTile(
                          //   leading: Icon(Icons.location_on),
                          //   title: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: const [
                          //       Text(
                          //         'Home:',
                          //         style: TextStyle(
                          //             fontWeight: FontWeight.bold,
                          //             color: Colors.black),
                          //       ),
                          //       Text(
                          //         'Some address which is locatable and in india',
                          //         overflow: TextOverflow.ellipsis,
                          //         style: TextStyle(color: Colors.black),
                          //       )
                          //     ],
                          //   ),
                          //   trailing: Image.asset('assets/pencil-icon.png'),
                          // ),
                          const SizedBox(
                            height: 10,
                          ),
                          const MItems(
                            index: 0,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const Text(
                            'my information',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          for (var i = 1; i < 6; i++)
                            MItems(
                              index: i,
                            ),
                          const SizedBox(height: 4),
                          const Text(
                            'other',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          for (var i = 6; i < 11; i++)
                            MItems(
                              index: i,
                            ),
                          const SizedBox(height: 10),
                          // IconButton(onPressed: (){}, icon: Image.asset('assets/log-out-white.png'))
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 40,
                              width: 120,
                              padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                              decoration: BoxDecoration(
                                  color: Colors.blueGrey[900],
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/DrawerIcon/log-out-white.png',
                                      height: 25,
                                      width: 25,
                                    ),
                                    const SizedBox(width: 2),
                                    const Text(
                                      'LOGOUT',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'app version v2.0',
                            style: TextStyle(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                    // Need to change it to splash screen
                    child: NewHomeView(),
                  );
                }));
          },
        ),
      )),
    );
  }
}

class MItems extends StatelessWidget {
  final int index;

  const MItems({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: () {
          print('$index  Tapped !!!! ${Constants.routeArray[index]}');
          if (Constants.routeArray[index] != null) {
            SlideDrawer.of(context).close();
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              print('came here!!');
              return Constants.routeArray[index];
            }));
          }
        },
        child: Row(
          children: [
            Image.asset(
              // 'assets/bell-icon.png',
              Constants.iconArray[index],
              height: 40,
              width: 40,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              Constants.itemArray[index],
              // 'Home',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 4,
      ),
    ]);
  }
}

//
// class GroceryLogin extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//         providers: [
//           BlocProvider<AppNoitceProvider>(
//             create: (context) => AppNoitceProvider(),
//           ),
//           BlocProvider<ImageSnapReview>(
//             create: (context) => ImageSnapReview(),
//           ),
//           BlocProvider<LocationEmitter>(
//             create: (context) => LocationEmitter(),
//           ),
//           BlocProvider<BottomNavigationEmitter>(
//             create: (context) => BottomNavigationEmitter(),
//           ),
//           BlocProvider<BanerProvider>(
//             create: (context) => BanerProvider(),
//           ),
//           BlocProvider<A2CartSnap>(
//             create: (context) =>
//                 A2CartSnap(AddtoCartB(status: false, prodId: -1)),
//           ),
//           BlocProvider<CartListProvider>(
//             create: (context) => CartListProvider(),
//           ),
//           BlocProvider<SingleApiEmitter>(
//             create: (context) => SingleApiEmitter(),
//           ),
//           BlocProvider<SearchProvider>(
//             create: (context) => SearchProvider(),
//           ),
//           BlocProvider<CategoryProvider>(
//             create: (context) => CategoryProvider(),
//           ),
//           BlocProvider<CartCountProvider>(
//             create: (context) => CartCountProvider(),
//           ),
//           BlocProvider<TopRecentNewDealProvider>(
//             create: (context) => TopRecentNewDealProvider(),
//           ),
//           BlocProvider<ProfileProvider>(
//             create: (context) => ProfileProvider(),
//           ),
//           BlocProvider<PageSnapReview>(
//             create: (context) => PageSnapReview(0),
//           ),
//           BlocProvider<LanguageCubit>(
//             create: (context) => LanguageCubit(),
//           ),
//         ],
//         child: BlocBuilder<LanguageCubit, Locale>(
//           builder: (_, locale) {
//             return MaterialApp(
//               builder: (context, child) {
//                 final MediaQueryData data = MediaQuery.of(context);
//                 return MediaQuery(
//                   data: data.copyWith(textScaleFactor: 1.0),
//                   child: child,
//                 );
//               },
//               debugShowCheckedModeBanner: false,
//               localizationsDelegates: const [
//                 AppLocalizationsDelegate(),
//                 GlobalMaterialLocalizations.delegate,
//                 GlobalCupertinoLocalizations.delegate,
//                 GlobalWidgetsLocalizations.delegate,
//               ],
//               supportedLocales: const [
//                 Locale('en'),
//                 Locale('ar'),
//                 Locale('pt'),
//                 Locale('fr'),
//                 Locale('id'),
//                 Locale('es'),
//               ],
//               locale: locale,
//               theme: appTheme,
//               // home: SignIn(),
//               initialRoute: PageRoutes.signInRoot,
//               routes: PageRoutes().routes(),
//             );
//           },
//         ));
//   }
// }

// class GroceryHome extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     getImageBaseUrl();
//     return MultiBlocProvider(
//         providers: [
//           BlocProvider<AppNoitceProvider>(
//             create: (context) => AppNoitceProvider(),
//           ),
//           BlocProvider<ImageSnapReview>(
//             create: (context) => ImageSnapReview(),
//           ),
//           BlocProvider<LocationEmitter>(
//             create: (context) => LocationEmitter(),
//           ),
//           BlocProvider<BottomNavigationEmitter>(
//             create: (context) => BottomNavigationEmitter(),
//           ),
//           BlocProvider<BanerProvider>(
//             create: (context) => BanerProvider(),
//           ),
//           BlocProvider<A2CartSnap>(
//             create: (context) =>
//                 A2CartSnap(AddtoCartB(status: false, prodId: -1)),
//           ),
//           BlocProvider<CartListProvider>(
//             create: (context) => CartListProvider(),
//           ),
//           BlocProvider<SingleApiEmitter>(
//             create: (context) => SingleApiEmitter(),
//           ),
//           BlocProvider<SearchProvider>(
//             create: (context) => SearchProvider(),
//           ),
//           BlocProvider<TopRecentNewDealProvider>(
//             create: (context) => TopRecentNewDealProvider(),
//           ),
//           BlocProvider<CategoryProvider>(
//             create: (context) => CategoryProvider(),
//           ),
//           BlocProvider<LanguageCubit>(
//             create: (context) => LanguageCubit(),
//           ),
//           BlocProvider<ProfileProvider>(
//             create: (context) => ProfileProvider(),
//           ),
//           BlocProvider<PageSnapReview>(
//             create: (context) => PageSnapReview(0),
//           ),
//           BlocProvider<CartCountProvider>(
//             create: (context) => CartCountProvider(),
//           ),
//         ],
//         child: BlocBuilder<LanguageCubit, Locale>(
//           builder: (_, locale) {
//             return MaterialApp(
//               builder: (context, child) {
//                 final MediaQueryData data = MediaQuery.of(context);
//                 return MediaQuery(
//                   data: data.copyWith(textScaleFactor: 1.0),
//                   child: child,
//                 );
//               },
//               debugShowCheckedModeBanner: false,
//               localizationsDelegates: [
//                 const AppLocalizationsDelegate(),
//                 GlobalMaterialLocalizations.delegate,
//                 GlobalCupertinoLocalizations.delegate,
//                 GlobalWidgetsLocalizations.delegate,
//               ],
//               supportedLocales: [
//                 const Locale('en'),
//                 const Locale('ar'),
//                 const Locale('pt'),
//                 const Locale('fr'),
//                 const Locale('id'),
//                 const Locale('es'),
//               ],
//               locale: locale,
//               theme: appTheme,
//               // home: NewHomeView(),
//               initialRoute: PageRoutes.homePage,
//               routes: PageRoutes().routes(),
//             );
//           },
//         ));
//   }
// }

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return MyHttpClient(super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true);
  }
}

class MyHttpClient implements HttpClient {
  HttpClient _realClient;

  MyHttpClient(this._realClient);

  @override
  bool get autoUncompress => _realClient.autoUncompress;

  @override
  set autoUncompress(bool value) => _realClient.autoUncompress = value;

  @override
  Duration get connectionTimeout => _realClient.connectionTimeout;

  @override
  set connectionTimeout(Duration value) =>
      _realClient.connectionTimeout = value;

  @override
  Duration get idleTimeout => _realClient.idleTimeout;

  @override
  set idleTimeout(Duration value) => _realClient.idleTimeout = value;

  @override
  int get maxConnectionsPerHost => _realClient.maxConnectionsPerHost;

  @override
  set maxConnectionsPerHost(int value) =>
      _realClient.maxConnectionsPerHost = value;

  @override
  String get userAgent => _realClient.userAgent;

  @override
  set userAgent(String value) => _realClient.userAgent = value;

  @override
  void addCredentials(
          Uri url, String realm, HttpClientCredentials credentials) =>
      _realClient.addCredentials(url, realm, credentials);

  @override
  void addProxyCredentials(String host, int port, String realm,
          HttpClientCredentials credentials) =>
      _realClient.addProxyCredentials(host, port, realm, credentials);

  @override
  void set authenticate(
          Future<bool> Function(Uri url, String scheme, String realm) f) =>
      _realClient.authenticate = f;

  @override
  void set authenticateProxy(
          Future<bool> Function(
                  String host, int port, String scheme, String realm)
              f) =>
      _realClient.authenticateProxy = f;

  @override
  void set badCertificateCallback(
          bool Function(X509Certificate cert, String host, int port)
              callback) =>
      _realClient.badCertificateCallback = callback;

  @override
  void close({bool force = false}) => _realClient.close(force: force);

  @override
  Future<HttpClientRequest> delete(String host, int port, String path) =>
      _realClient.delete(host, port, path);

  @override
  Future<HttpClientRequest> deleteUrl(Uri url) => _realClient.deleteUrl(url);

  @override
  void set findProxy(String Function(Uri url) f) => _realClient.findProxy = f;

  @override
  Future<HttpClientRequest> get(String host, int port, String path) =>
      _updateHeaders(_realClient.get(host, port, path));

  Future<HttpClientRequest> _updateHeaders(
      Future<HttpClientRequest> httpClientRequest) async {
    return (await httpClientRequest)
      ..headers.add("Access-Control-Allow-Origin", "*")
      ..headers.add("Access-Control-Allow-Headers",
          "Origin, X-Requested-With, Content-Type, Accept, Authorization")
      ..headers
          .add("Access-Control-Allow-Methods", "PUT, POST, DELETE, GET, PATCH");
  }

  @override
  Future<HttpClientRequest> getUrl(Uri url) =>
      _updateHeaders(_realClient.getUrl(url.replace(path: url.path)));

  @override
  Future<HttpClientRequest> head(String host, int port, String path) =>
      _realClient.head(host, port, path);

  @override
  Future<HttpClientRequest> headUrl(Uri url) => _realClient.headUrl(url);

  @override
  Future<HttpClientRequest> open(
          String method, String host, int port, String path) =>
      _realClient.open(method, host, port, path);

  @override
  Future<HttpClientRequest> openUrl(String method, Uri url) =>
      _realClient.openUrl(method, url);

  @override
  Future<HttpClientRequest> patch(String host, int port, String path) =>
      _realClient.patch(host, port, path);

  @override
  Future<HttpClientRequest> patchUrl(Uri url) => _realClient.patchUrl(url);

  @override
  Future<HttpClientRequest> post(String host, int port, String path) =>
      _realClient.post(host, port, path);

  @override
  Future<HttpClientRequest> postUrl(Uri url) => _realClient.postUrl(url);

  @override
  Future<HttpClientRequest> put(String host, int port, String path) =>
      _realClient.put(host, port, path);

  @override
  Future<HttpClientRequest> putUrl(Uri url) => _realClient.putUrl(url);
}
