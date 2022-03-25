import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user/Locale/locales.dart';
import 'package:user/Pages/HomePage/product_card.dart';
import 'package:user/Theme/colors.dart';
import 'package:user/baseurl/baseurlg.dart';
import 'package:user/beanmodel/cart/cartitembean.dart';
import 'package:user/beanmodel/storefinder/storefinderbean.dart';
import 'package:user/providergrocery/bottomnavigationnavigator.dart';
import 'package:user/providergrocery/cartcountprovider.dart';
import 'package:user/providergrocery/categoryprovider.dart';
import 'package:user/providergrocery/locemittermodel.dart';

import 'new_custom_app_bar.dart';

class SubCategoryPage extends StatefulWidget {
  final LocEmitterModel locModel;
  final List<CartItemData> cartItemd;

  const SubCategoryPage({Key key, this.locModel, this.cartItemd})
      : super(key: key);

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  CategoryProvider cateP;
  bool isEnteredFirst = false;
  bool islogin = true;
  var userName = '--';
  dynamic _scanBarcode;
  int selectedInd = 0;
  dynamic hintText = '--';
  String appbarTitle = '--';
  String title = 'Fruits and Vegetables';
  dynamic lat;
  dynamic lng;
  dynamic currentAddress = 'Tap/Set to change your location.';
  StoreFinderData storeFinderData;
  BottomNavigationEmitter navBottomProvider;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 200),
        child: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
          NewCustomAppBar(
            title: 'Category',
            backgroundImage:
                'assets/CategoryImages/fruit-vegitables-bottom.png',
          ),
          Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Positioned.fill(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0)),
                child: Image.asset(
                  'assets/CategoryImages/fruits-vegitables.png',
                  // height: MediaQuery.of(context).size.height * 0.5,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          )
        ]),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: 2,
        itemBuilder: (context, index) => ProductCard(
          locModel: widget.locModel,
          catP: cateP,
          locale: locale,
          index: index,
          height: 80,
          width: 80,
          title: "Brocolli",
          subTitle: '500g',
          symbol: '\u{20B9}',
          previousPrice: '35',
          newPrice: '36.55',
          image: 'assets/CategoryImages/fruits-vegitables.png',
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 12.0,
        color: kMainColor,
        clipBehavior: Clip.antiAlias,
        shape: const CircularNotchedRectangle(),
        child: SizedBox(
          height: 52,
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
                        0, appbarTitle, '${locale.searchOnGoGrocer}$appname');
                    // hintText = ;
                    // setState(() {
                    //   selectedInd = 0;
                    //
                    // });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(
                      //   Icons.home,
                      //   color: (selectedInd == 0)
                      //       ? kMainColor
                      //       : kMainTextColor,
                      // ),
                      Image.asset(
                        'assets/ic_home.png',
                        width: 20,
                        height: 20,
                        color: (selectedInd == 0)
                            ? kWhiteColor
                            : kNavigationButtonColor,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            color: (selectedInd == 0)
                                ? kWhiteColor
                                : kNavigationButtonColor),
                      )
                    ],
                  ),
                ),
                // Expanded(
                //   child: GestureDetector(
                //     onTap: () {
                //       if (selectedInd != 1) {
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
                //           color: (selectedInd == 1)
                //               ? kMainColor
                //               : kMainTextColor,
                //         ),
                //         Text(
                //           "Categories",
                //           style: TextStyle(
                //               color: (selectedInd == 1)
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
                        1, "My Orders", '${locale.searchOnGoGrocer}$appname');
                    // hintText = ;
                    // setState(() {
                    //   selectedInd = 2;
                    // });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(
                      //   Icons.search,
                      //   color: (selectedInd == 2)
                      //       ? kMainColor
                      //       : kMainTextColor,
                      // ),
                      Image.asset(
                        'assets/ic_order.png',
                        width: 20,
                        height: 20,
                        color: (selectedInd == 1)
                            ? kWhiteColor
                            : kNavigationButtonColor,
                      ),

                      Text(
                        "Order",
                        style: TextStyle(
                            color: (selectedInd == 1)
                                ? kWhiteColor
                                : kNavigationButtonColor),
                      )
                    ],
                  ),
                ),
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
                    //   // selectedInd = 0;
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
                        return Image.asset(
                          'assets/ic_wallet.png',
                          width: 20,
                          height: 20,
                          color: (selectedInd == 2)
                              ? kWhiteColor
                              : kNavigationButtonColor,

                          // Icon(
                          //   Icons.shopping_basket,
                          //   color: kMainTextColor,
                          // ),
                        );
                      }),
                      Text(
                        "Wallet",
                        style: TextStyle(
                          color: (selectedInd == 2)
                              ? kWhiteColor
                              : kNavigationButtonColor,
                        ),
                      )
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // if (selectedInd != 0 &&
                    //     selectedInd != 1 &&
                    //     selectedInd != 2 &&
                    //     selectedInd != 3) {
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
                      //   color: (selectedInd == 3)
                      //       ? kMainColor
                      //       : kMainTextColor,
                      // ),
                      Image.asset(
                        'assets/ic_account.png',
                        width: 20,
                        height: 20,
                        color: (selectedInd == 3)
                            ? kWhiteColor
                            : kNavigationButtonColor,
                      ),

                      Text(
                        "Account",
                        style: TextStyle(
                            color: (selectedInd == 3)
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
  }
}
