import 'package:flutter/material.dart';
import 'package:user/Locale/locales.dart';
import 'package:user/Pages/HomePage/product_card.dart';
import 'package:user/Theme/colors.dart';
import 'package:user/baseurl/baseurlg.dart';
import 'package:user/providergrocery/categoryprovider.dart';
import 'package:user/providergrocery/locemittermodel.dart';

class ProductsCardWithTitle extends StatelessWidget {
  final LocEmitterModel locModel;
  final CategoryProvider catP;
  final AppLocalizations locale;
  final String title;
  final int count;
  bool isAlwaysSubscribe = false;

  final List<dynamic> data;

  ProductsCardWithTitle(
      {Key key,
      @required this.title,
      @required this.locModel,
      @required this.catP,
      @required this.locale,
      this.count,
      this.isAlwaysSubscribe,
      this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: kMainTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () {
                  //   if (locModel.storeFinderData != null) {
                  //     if (!catP.state.isSearching) {
                  //       catP.hitBannerDetails(
                  //           '${locModel.storeFinderData.store_id}',
                  //           locModel.storeFinderData);
                  //     } else {
                  //       Toast.show(locale.aa1, context,
                  //           duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                  //     }
                  //   }
                },
                behavior: HitTestBehavior.opaque,
                child: Text(
                  'View All',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: kMainColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: count ?? 2,
              itemBuilder: (context, index) {
                String _string = data != null
                    ? data[index].productImage
                    : 'assets/ProductImages/Garlic.png';
                print(_string);
                if (data != null) {
                  _string = _string.substring(1, _string.length);
                  _string = imagebaseUrl1 + _string;
                }
                String _title = 'Garlic';
                if (data != null) {
                  try {
                    _title = data[index].productName;
                  } catch (e) {
                    try {
                      _title = data[index].title;
                    } catch (e) {
                      _title = 'Garlic';
                    }
                  }
                }

                return ProductCard(
                  index: index,
                  image: _string,
                  title: _title,
                  // TODO: Change here condition after the is_subscribe is available in API
                  isSubscribe: isAlwaysSubscribe,
                  subTitle: '500g',
                  symbol: '\u{20B9}',
                  previousPrice: '35',
                  newPrice: '36.55',
                  locModel: locModel,
                  catP: catP,
                  locale: locale,
                  total: 5,
                );
              },
            ),
          ),

          // Row(
          //   children: [
          //     Expanded(child: ProductCard()),
          //     Expanded(child: ProductCard()),
          //   ],
          // )
        ],
      ),
    );
  }
}
