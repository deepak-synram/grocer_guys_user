import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:user/Locale/locales.dart';
import 'package:user/Pages/HomePage/product_card.dart';
import 'package:user/Theme/colors.dart';
import 'package:user/baseurl/api_services.dart';
import 'package:user/beanmodel/searchmodel/searchkeyword.dart';
import 'package:user/providergrocery/categoryprovider.dart';
import 'package:user/providergrocery/locemittermodel.dart';

class SearchProduct extends StatefulWidget {
  final LocEmitterModel locModel;
  final CategoryProvider catP;
  final AppLocalizations locale;

  const SearchProduct({
    Key key,
    @required this.locModel,
    @required this.catP,
    @required this.locale,
  }) : super(key: key);
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  String searchString = '';
  TextEditingController controller = TextEditingController();
  ProductSearchModel psm;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: kWhiteColor),
          backgroundColor: kMainColor,
          title: Container(
            height: 42.0,
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: kMainColor),
                hintText: "Search",
                contentPadding: const EdgeInsets.only(top: 5.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: kMainColor,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: kMainColor,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 50),
                      primary: kNavigationButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(
                      "Search",
                      style: TextStyle(color: kMainColor),
                    ),
                    onPressed: () async {
                      try {
                        setState(() {
                          _isLoading = true;
                        });
                        ProductSearchModel _psm =
                            await ApiServices.getProductFromKeyword(
                                searchString, '3', '');
                        log(_psm.toString());
                        if (_psm?.data != null) {
                          setState(() {
                            psm = _psm;
                          });
                        }
                      } catch (e) {
                        log(e.toString());
                        Future.error(e);
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          // TextFormField(
          //   controller: controller,
          //   onChanged: (value) async {
          //     searchString = value;
          //   },
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(20.0),
          //       borderSide: const BorderSide(
          //         width: 0,
          //         style: BorderStyle.none,
          //       ),
          //     ),

          //     fillColor: Colors.white,
          //     suffix: GestureDetector(
          //       onTap: () async {
          //         try {
          //           setState(() {
          //             _isLoading = true;
          //           });
          //           ProductSearchModel _psm =
          //               await ApiServices.getProductFromKeyword(
          //                   searchString, '3', '');
          //           log(_psm.toString());
          //           if (_psm?.data != null) {
          //             setState(() {
          //               psm = _psm;
          //             });
          //           }
          //         } catch (e) {
          //           log(e.toString());
          //           Future.error(e);
          //         } finally {
          //           setState(() {
          //             _isLoading = false;
          //           });
          //         }
          //       },
          //       child: Container(
          //         height: 40.0,
          //         width: 40.0,
          //         decoration: BoxDecoration(
          //           color: kNavigationButtonColor,
          //           borderRadius: const BorderRadius.all(
          //             Radius.circular(10.0),
          //           ),
          //         ),
          //         child: Icon(
          //           Icons.search,
          //           color: kMainColor,
          //         ),
          //       ),
          //     ),
          //     // suffixIcon: IconButton(
          //     //   onPressed: () {
          //     //     controller.clear();
          //     //     FocusScope.of(context).unfocus();
          //     //   },
          //     //   icon: const Icon(
          //     //     Icons.close,
          //     //     color: Colors.black,
          //     //   ),
          //     // ),
          //     hintText: 'Search for products .....',
          //     hintStyle: const TextStyle(
          //       color: Colors.grey,
          //     ),
          //     contentPadding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
          //   ),
          // ),
        ),
        body: psm?.data == null
            ? const SizedBox.shrink()
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.65,
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.0,
                  crossAxisSpacing: 15.0,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(
                    total: 10,
                    locModel: widget.locModel,
                    catP: widget.catP,
                    locale: widget.locale,
                    index: index,
                    title: psm?.data[index]?.productName,
                    image: psm?.data[index]?.productImage ??
                        'assets/HomeBanner/no-icon.png',
                    subTitle: '500g',
                    symbol: '\u{20B9}',
                    previousPrice: '35',
                    newPrice: '36.55',
                  );
                },
                itemCount: psm?.data?.length,
              ),
      ),
    );
  }
}
