import 'package:flutter/material.dart';
import 'package:user/Locale/locales.dart';
import 'package:user/Pages/HomePage/product_card.dart';
import 'package:user/beanmodel/cart/cartitembean.dart';
import 'package:user/beanmodel/singleapibean.dart';
import 'package:user/beanmodel/storefinder/storefinderbean.dart';
import 'package:user/providergrocery/bottomnavigationnavigator.dart';
import 'package:user/providergrocery/categoryprovider.dart';
import 'package:user/providergrocery/locemittermodel.dart';

import 'new_custom_app_bar.dart';

class SubCategoryPage extends StatefulWidget {
  final LocEmitterModel locModel;
  final List<CartItemData> cartItemd;
  final TopCat cat;
  final String appBarImage;

  const SubCategoryPage(
      {Key key, this.locModel, this.cartItemd, this.cat, this.appBarImage})
      : super(key: key);

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  CategoryProvider cateP;
  bool isEnteredFirst = false;
  bool islogin = true;
  var userName = '--';
  int selectedInd = 0;
  dynamic hintText = '--';
  String appbarTitle = '--';
  dynamic lat;
  dynamic lng;
  dynamic currentAddress = 'Tap/Set to change your location.';
  StoreFinderData storeFinderData;
  BottomNavigationEmitter navBottomProvider;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 200),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            NewCustomAppBar(
              title: 'Category',
              backgroundImage: widget.appBarImage ??
                  'assets/CategoryImages/fruit-vegitables-bottom.png',
            ),
            Align(
              alignment: const Alignment(0.0, 2.0),
              // child: widget.cat != null
              //     ? Image.network(
              //         '$imagebaseUrl1 + ${widget.cat.image.substring(1)}',
              //         height: 120,
              //         width: 120,
              //         // height: MediaQuery.of(context).size.height * 0.5,
              //         alignment: Alignment.bottomCenter,
              //       )
              child: Image.asset(
                'assets/CategoryImages/fruits-vegitables.png',
                height: 120,
                width: 120,
                // height: MediaQuery.of(context).size.height * 0.5,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ],
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              itemBuilder: (context, index) {
                return ProductCard(
                  total: 4,
                  isSubscribe: false,
                  locModel: widget.locModel,
                  catP: cateP,
                  locale: locale,
                  index: index,
                  // height: 80,
                  // width: 80,
                  title: "Garlic",
                  subTitle: '500g',
                  symbol: '\u{20B9}',
                  previousPrice: '35',
                  newPrice: '36.55',
                  image: 'assets/ProductImages/Garlic.png',
                );
              },
            ),
          ],
        ),
      ),
      // bottomNavigationBar: BottomAppBar(
      //   notchMargin: 12.0,
      //   color: kMainColor,
      //   clipBehavior: Clip.antiAlias,
      //   shape: const CircularNotchedRectangle(),
      //   child: SizedBox(
      //     height: 52,
      //     child: Padding(
      //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //       child: Row(
      //         // crossAxisAlignment: CrossAxisAlignment.center,
      //         mainAxisSize: MainAxisSize.max,
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: [
      //           GestureDetector(
      //             onTap: () {
      //               navBottomProvider.hitBottomNavigation(
      //                   0, appbarTitle, '${locale.searchOnGoGrocer}$appname');
      //               // hintText = ;
      //               // setState(() {
      //               //   selectedInd = 0;
      //               //
      //               // });
      //             },
      //             behavior: HitTestBehavior.opaque,
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 // Icon(
      //                 //   Icons.home,
      //                 //   color: (selectedInd == 0)
      //                 //       ? kMainColor
      //                 //       : kMainTextColor,
      //                 // ),
      //                 Image.asset(
      //                   'assets/ic_home.png',
      //                   width: 20,
      //                   height: 20,
      //                   color: (selectedInd == 0)
      //                       ? kWhiteColor
      //                       : kNavigationButtonColor,
      //                 ),
      //                 Text(
      //                   "Home",
      //                   style: TextStyle(
      //                       color: (selectedInd == 0)
      //                           ? kWhiteColor
      //                           : kNavigationButtonColor),
      //                 )
      //               ],
      //             ),
      //           ),
      //           // Expanded(
      //           //   child: GestureDetector(
      //           //     onTap: () {
      //           //       if (selectedInd != 1) {
      //           //         navBottomProvider.hitBottomNavigation(
      //           //             1,
      //           //             'Category',
      //           //             'what are you looking for (e.g. mango, onion)');
      //           //         if (storeFinderData != null) {
      //           //           if (!cateP.state.isSearching) {
      //           //             cateP.hitBannerDetails(
      //           //                 '${storeFinderData.store_id}',
      //           //                 storeFinderData);
      //           //           } else {
      //           //             Toast.show('currently in progress', context,
      //           //                 duration: Toast.LENGTH_SHORT,
      //           //                 gravity: Toast.CENTER);
      //           //           }
      //           //         }
      //           //       }
      //           //     },
      //           //     behavior: HitTestBehavior.opaque,
      //           //     child: Column(
      //           //       mainAxisAlignment: MainAxisAlignment.center,
      //           //       children: [
      //           //         Icon(
      //           //           Icons.category,
      //           //           color: (selectedInd == 1)
      //           //               ? kMainColor
      //           //               : kMainTextColor,
      //           //         ),
      //           //         Text(
      //           //           "Categories",
      //           //           style: TextStyle(
      //           //               color: (selectedInd == 1)
      //           //                   ? kMainColor
      //           //                   : kMainTextColor),
      //           //         )
      //           //       ],
      //           //     ),
      //           //   ),
      //           // ),
      //           GestureDetector(
      //             onTap: () {
      //               // searchP.emitSearchNull();
      //               navBottomProvider.hitBottomNavigation(
      //                   1, "My Orders", '${locale.searchOnGoGrocer}$appname');
      //               // hintText = ;
      //               // setState(() {
      //               //   selectedInd = 2;
      //               // });
      //             },
      //             behavior: HitTestBehavior.opaque,
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 // Icon(
      //                 //   Icons.search,
      //                 //   color: (selectedInd == 2)
      //                 //       ? kMainColor
      //                 //       : kMainTextColor,
      //                 // ),
      //                 Image.asset(
      //                   'assets/ic_order.png',
      //                   width: 20,
      //                   height: 20,
      //                   color: (selectedInd == 1)
      //                       ? kWhiteColor
      //                       : kNavigationButtonColor,
      //                 ),

      //                 Text(
      //                   "Order",
      //                   style: TextStyle(
      //                       color: (selectedInd == 1)
      //                           ? kWhiteColor
      //                           : kNavigationButtonColor),
      //                 )
      //               ],
      //             ),
      //           ),
      //           GestureDetector(
      //             onTap: () {
      //               // Navigator.of(context)
      //               //     .pushNamed(PageRoutes.yourbasket)
      //               //     .then((value) {
      //               //   navBottomProvider.hitBottomNavigation(
      //               //       0,
      //               //       appbarTitle,
      //               //       '${locale.searchOnGoGrocer}$appname');
      //               //   // hintText = ;
      //               // });
      //               navBottomProvider.hitBottomNavigation(
      //                   2, 'My Wallets', hintText);

      //               // setState(() {
      //               //   // selectedInd = 0;
      //               // });
      //             },
      //             behavior: HitTestBehavior.opaque,
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 BlocBuilder<CartCountProvider, int>(
      //                     builder: (context, cartCount) {
      //                   // return Badge(
      //                   //   padding: const EdgeInsets.all(5),
      //                   //   animationDuration:
      //                   //       const Duration(milliseconds: 300),
      //                   //   animationType: BadgeAnimationType.slide,
      //                   //   badgeContent: Text(
      //                   //     cartCount.toString(),
      //                   //     style: TextStyle(
      //                   //         color: kWhiteColor, fontSize: 10),
      //                   //   ),
      //                   //   child:
      //                   return Image.asset(
      //                     'assets/ic_wallet.png',
      //                     width: 20,
      //                     height: 20,
      //                     color: (selectedInd == 2)
      //                         ? kWhiteColor
      //                         : kNavigationButtonColor,

      //                     // Icon(
      //                     //   Icons.shopping_basket,
      //                     //   color: kMainTextColor,
      //                     // ),
      //                   );
      //                 }),
      //                 Text(
      //                   "Wallet",
      //                   style: TextStyle(
      //                     color: (selectedInd == 2)
      //                         ? kWhiteColor
      //                         : kNavigationButtonColor,
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //           GestureDetector(
      //             onTap: () {
      //               // if (selectedInd != 0 &&
      //               //     selectedInd != 1 &&
      //               //     selectedInd != 2 &&
      //               //     selectedInd != 3) {
      //               //   cartCountP.hitCounter();
      //               // }
      //               navBottomProvider.hitBottomNavigation(
      //                   3, 'Account', hintText);
      //             },
      //             behavior: HitTestBehavior.opaque,
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 // Icon(
      //                 //   Icons.account_box_outlined,
      //                 //   color: (selectedInd == 3)
      //                 //       ? kMainColor
      //                 //       : kMainTextColor,
      //                 // ),
      //                 Image.asset(
      //                   'assets/ic_account.png',
      //                   width: 20,
      //                   height: 20,
      //                   color: (selectedInd == 3)
      //                       ? kWhiteColor
      //                       : kNavigationButtonColor,
      //                 ),

      //                 Text(
      //                   "Account",
      //                   style: TextStyle(
      //                       color: (selectedInd == 3)
      //                           ? kWhiteColor
      //                           : kNavigationButtonColor),
      //                 )
      //               ],
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
