import 'package:flutter/material.dart';
import 'package:user/Locale/locales.dart';
import 'package:user/Pages/HomePage/product_card.dart';
import 'package:user/beanmodel/cart/cartitembean.dart';
import 'package:user/beanmodel/storefinder/storefinderbean.dart';
import 'package:user/providergrocery/bottomnavigationnavigator.dart';
import 'package:user/providergrocery/categoryprovider.dart';
import 'package:user/providergrocery/locemittermodel.dart';

import 'new_custom_app_bar.dart';

class SubCategoryPageDetails extends StatefulWidget {
  final LocEmitterModel locModel;
  final List<CartItemData> cartItemd;
  final dynamic cat;
  final String appBarImage;

  const SubCategoryPageDetails(
      {Key key, this.locModel, this.cartItemd, this.cat, this.appBarImage})
      : super(key: key);

  @override
  _SubCategoryPageDetailsState createState() => _SubCategoryPageDetailsState();
}

class _SubCategoryPageDetailsState extends State<SubCategoryPageDetails> {
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
    );
  }
}
