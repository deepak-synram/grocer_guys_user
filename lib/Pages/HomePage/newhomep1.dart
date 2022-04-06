import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:http/http.dart';
import 'package:marquee/marquee.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:user/Components/constantfile.dart';
import 'package:user/Locale/locales.dart';
import 'package:user/Pages/HomePage/category_card.dart';
import 'package:user/Pages/HomePage/product_card_with_title.dart';
import 'package:user/Pages/categorypage/sub_category_page.dart';
import 'package:user/Pages/categorypage/view_all_categories.dart';
import 'package:user/Theme/colors.dart';
import 'package:user/baseurl/api_services.dart';
import 'package:user/baseurl/baseurlg.dart';
import 'package:user/beanmodel/appinfo.dart';
import 'package:user/beanmodel/appnotice/appnotice.dart';
import 'package:user/beanmodel/cart/addtocartbean.dart';
import 'package:user/beanmodel/cart/cartitembean.dart';
import 'package:user/beanmodel/category/categorymodel.dart';
import 'package:user/beanmodel/coupon/storecoupon.dart';
import 'package:user/beanmodel/productbean/subscriber_product_model.dart';
import 'package:user/beanmodel/singleapibean.dart' as sa;
import 'package:user/beanmodel/tablist.dart';
import 'package:user/providergrocery/add2cartsnap.dart';
import 'package:user/providergrocery/appnoticeprovider.dart';
import 'package:user/providergrocery/benprovider/appnoticebean.dart';
import 'package:user/providergrocery/benprovider/singleapiemittermodel.dart';
import 'package:user/providergrocery/bottomnavigationnavigator.dart';
import 'package:user/providergrocery/cartcountprovider.dart';
import 'package:user/providergrocery/cartlistprovider.dart';
import 'package:user/providergrocery/categoryprovider.dart';
import 'package:user/providergrocery/locemittermodel.dart';
import 'package:user/providergrocery/pagesnap.dart';
import 'package:user/providergrocery/singleapiemiter.dart';
import 'package:user/providergrocery/trndlistemitter.dart';

class NewHomeView1 extends StatefulWidget {
  LocEmitterModel locModel;
  List<CartItemData> cartItemd;

  NewHomeView1(this.locModel, this.cartItemd);

  @override
  State<StatefulWidget> createState() {
    return NewHomeView1State();
  }
}

class NewHomeView1State extends State<NewHomeView1> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  var http = Client();
  bool isEnteredFirst = false;
  List<Tablist> tabList = [];
  // List<TabsD> tabDataList = [];
  int selectTabt = 0;
  PageSnapReview pageSnap;
  String shownMessage = '--';

  String store_id = '';
  String storeName = '--';
  bool loci = false;
  bool progressadd = false;
  CartListProvider cartListPro;
  CartCountProvider cartCounterProvider;
  A2CartSnap a2cartSnap;
  SingleApiEmitter singleApiEmitter;
  TopRecentNewDealProvider trndProvider;
  BottomNavigationEmitter navBottomProvider;
  dynamic apCurrency = '-';
  CategoryProvider cateP;
  bool isCouponLoading = false;
  List<StoreCouponData> offers = [];
  AppNoitceProvider appNotice;
  CategoryModel _categoryModel;

  List<String> staticIcon = [
    'assets/CategoryImages/snacks-branded-food.png',
    'assets/CategoryImages/food-grain-oil-masala.png',
    'assets/CategoryImages/bakery-cake-dairy.png',
    'assets/CategoryImages/fruits-vegitables.png',
    'assets/CategoryImages/fruits-vegitables.png',
    'assets/CategoryImages/bakery-cake-dairy.png',
  ];

  List<String> staticImage = [
    'assets/CategoryImages/snacks-branded-food-bottom.png',
    'assets/CategoryImages/food-grains-oil-masala-bottom.png',
    'assets/CategoryImages/bakery-cake-dairy-bottom.png',
    'assets/CategoryImages/fruit-vegitables-bottom.png',
    'assets/CategoryImages/fruit-vegitables-bottom.png',
    'assets/CategoryImages/bakery-cake-dairy-bottom.png',
  ];

  List<Color> staticColor = [
    const Color.fromRGBO(79, 130, 50, 1.0),
    const Color.fromRGBO(143, 41, 52, 1.0),
    const Color.fromRGBO(101, 178, 169, 1.0),
    const Color.fromRGBO(185, 78, 117, 1.0),
    const Color.fromRGBO(101, 178, 169, 1.0),
    const Color.fromRGBO(185, 78, 117, 1.0),
  ];

  SubscriberProducts sProducts;

  @override
  void initState() {
    getapCurrency();
    getSubscriberProducts();
    super.initState();
  }

  void getSubscriberProducts() async {
    sProducts = await ApiServices.getSubscribeProductList();
  }

  void getapCurrency() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    apCurrency = preferences.getString('app_currency');
  }

  void getCouponList(String storeid) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    // setState(() {
    //   isCouponLoading = true;
    // });
    var http = Client();
    http.post(storeCouponsUri, body: {
      'store_id': storeid,
      'cart_id': ''
    }, headers: {
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    }).then((value) {
      print('vv - ${value.body}');
      if (value.statusCode == 200) {
        StoreCouponMain couponData =
            StoreCouponMain.fromJson(jsonDecode(value.body));
        if (couponData.status == '1' || couponData.status == 1) {
          setState(() {
            offers.clear();
            if (couponData.data.length > 5) {
              List<StoreCouponData> offersd = couponData.data.sublist(0, 5);
              offers = List.from(offersd);
            } else {
              offers = List.from(couponData.data);
            }
          });
        }
      }
      // setState(() {
      //   isCouponLoading = false;
      // });
    }).catchError((e) {
      print(e);
      // setState(() {
      //   isCouponLoading = false;
      // });
    });
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

  void _onRefresh() async {
    print('onrefresh');
    singleApiEmitter.hitSingleApiEmitter(
        '${widget.locModel.storeFinderData.store_id}', _refreshController);
    getCouponList('${widget.locModel.storeFinderData.store_id}');
    hitAppNotice();
  }

  void _onLoading() async {
    print('onloading');
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    print('ty ty1 -> $isEnteredFirst');
    if (!isEnteredFirst) {
      isEnteredFirst = true;
      pageSnap = BlocProvider.of<PageSnapReview>(context);
      cartListPro = BlocProvider.of<CartListProvider>(context);
      cartCounterProvider = BlocProvider.of<CartCountProvider>(context);
      a2cartSnap = BlocProvider.of<A2CartSnap>(context);
      singleApiEmitter = BlocProvider.of<SingleApiEmitter>(context);
      trndProvider = BlocProvider.of<TopRecentNewDealProvider>(context);
      print('${widget.locModel.storeFinderData.store_id}');
      navBottomProvider = BlocProvider.of<BottomNavigationEmitter>(context);
      appNotice = BlocProvider.of<AppNoitceProvider>(context);
      cateP = BlocProvider.of<CategoryProvider>(context);
      singleApiEmitter.hitSingleApiEmitter(
          '${widget.locModel.storeFinderData.store_id}', _refreshController);
      getCouponList('${widget.locModel.storeFinderData.store_id}');
      print('ty ty -> $isEnteredFirst');
    }

    return Scaffold(
      body: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        header: WaterDropHeader(),
        footer: CustomFooter(builder: (context, mode) {
          return Text('');
        }),
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<AppNoitceProvider, AppNoticeBean>(
                builder: (context, apiData) {
                  if (apiData != null && '${apiData.status}' == '1') {
                    return Container(
                      height: 20,
                      // margin: EdgeInsets.only(top: 1),
                      decoration: BoxDecoration(
                        color: kMainTextColor,
                      ),
                      alignment: Alignment.center,
                      child: (apiData.notice != null &&
                              apiData.notice.length > 15)
                          ? Marquee(
                              text: apiData.notice,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: kMarqueeColor),
                              scrollAxis: Axis.horizontal,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              blankSpace: 5.0,
                              velocity: 100.0,
                              pauseAfterRound: Duration(seconds: 1),
                              startPadding: 10.0,
                              accelerationDuration: Duration(seconds: 1),
                              accelerationCurve: Curves.linear,
                              decelerationDuration: Duration(milliseconds: 500),
                              decelerationCurve: Curves.easeOut,
                            )
                          : SizedBox.shrink(),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
                buildWhen: (pre, current) {
                  return pre != current;
                },
              ),
              Expanded(
                child: Container(
                  color: kMainPageBGColor,
                  child:
                      BlocBuilder<SingleApiEmitter, SingleApiEmitterBeanModel>(
                    builder: (context, apiData) {
                      print('d enter -> ${apiData.isSearching}');
                      if (apiData.isSearching) {
                        print('is enter');
                        return buildSingleScreenView(context);
                      } else {
                        print(apiData.dataModel.status);
                        if (apiData != null &&
                            apiData.dataModel.status == '1') {
                          print('Data Found !!!');
                          // tabList = [];
                          // if (apiData.dataModel.tabs != null &&
                          //     apiData.dataModel.tabs.isNotEmpty) {
                          //   for (int i = 0;
                          //       i < apiData.dataModel.tabs.length;
                          //       i++) {
                          //     tabList.add(
                          //         Tablist(apiData.dataModel.tabs[i].type, i));
                          //   }
                          //   tabDataList = List.from(apiData.dataModel.tabs);
                          //   trndProvider.hitTopRecentNewDealPro(
                          //       tabDataList[selectTabt].data, selectTabt);
                          // }
                          return SingleChildScrollView(
                            primary: true,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                (apiData.dataModel.banner != null &&
                                        apiData.dataModel.banner.isNotEmpty)
                                    ?
                                    // Container(
                                    //     height: 200,
                                    //     margin: const EdgeInsets.symmetric(
                                    //         vertical: 10),
                                    //     alignment: Alignment.centerRight,
                                    //     child: ListView.builder(
                                    //       scrollDirection: Axis.horizontal,
                                    //       shrinkWrap: true,
                                    //       itemBuilder: (context, index) {
                                    //         return GestureDetector(
                                    //           onTap: () {
                                    //             Navigator.pushNamed(context,
                                    //                 PageRoutes.cat_product,
                                    //                 arguments: {
                                    //                   'title': apiData.dataModel
                                    //                       .banner[index].title,
                                    //                   'storeid': apiData
                                    //                       .dataModel
                                    //                       .banner[index]
                                    //                       .store_id,
                                    //                   'cat_id': apiData
                                    //                       .dataModel
                                    //                       .banner[index]
                                    //                       .cat_id,
                                    //                   'storedetail': widget
                                    //                       .locModel
                                    //                       .storeFinderData,
                                    //                 });
                                    //           },
                                    //           behavior: HitTestBehavior.opaque,
                                    //           child: Container(
                                    //             width: MediaQuery.of(context)
                                    //                     .size
                                    //                     .width *
                                    //                 0.80,
                                    //             margin:
                                    //                 const EdgeInsets.symmetric(
                                    //                     horizontal: 5),
                                    //             height: 180,
                                    //             decoration: BoxDecoration(
                                    //                 color: kWhiteColor,
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(
                                    //                         5)),
                                    //             child: ClipRRect(
                                    //               borderRadius:
                                    //                   BorderRadius.circular(5),
                                    //               child: CachedNetworkImage(
                                    //                 imageUrl:
                                    //                     '${apiData.dataModel.banner[index].banner_image}',
                                    //                 placeholder:
                                    //                     (context, url) => Align(
                                    //                   widthFactor: 50,
                                    //                   heightFactor: 50,
                                    //                   alignment:
                                    //                       Alignment.center,
                                    //                   child: Container(
                                    //                     padding:
                                    //                         const EdgeInsets
                                    //                             .all(5.0),
                                    //                     width: 50,
                                    //                     height: 180,
                                    //                     child:
                                    //                         const CircularProgressIndicator(),
                                    //                   ),
                                    //                 ),
                                    //                 errorWidget:
                                    //                     (context, url, error) =>
                                    //                         Image.asset(
                                    //                   'assets/icon.png',
                                    //                   fit: BoxFit.fill,
                                    //                 ),
                                    //                 fit: BoxFit.fill,
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         );
                                    //       },
                                    //       itemCount:
                                    //           apiData.dataModel.banner.length,
                                    //     ),
                                    //   )
                                    Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: ImageSlideshow(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: 200,
                                          initialPage: 0,
                                          indicatorColor:
                                              kNavigationButtonColor,
                                          indicatorBackgroundColor: kWhiteColor,
                                          children: apiData.dataModel.banner
                                              .map(
                                                (sa.BannerDataModel
                                                        dataModel) =>
                                                    ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        '$imagebaseUrl1${dataModel.bannerImage.substring(1)}',
                                                    placeholder:
                                                        (context, url) => Align(
                                                      widthFactor: 50,
                                                      heightFactor: 50,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        width: 50,
                                                        height: 180,
                                                        child: const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                      ),
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Center(
                                                      child: Image.asset(
                                                        'assets/HomeBanner/no-icon.png',
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                          onPageChanged: (value) {},
                                          autoPlayInterval: 3000,
                                          isLoop: true,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                // (tabList != null && tabList.isNotEmpty)
                                //     ? BlocBuilder<TopRecentNewDealProvider,
                                //         TopRecentNewDataBean>(
                                //         builder: (context, showindex) {
                                //           selectTabt = showindex.index;
                                //           return (showindex != null &&
                                //                   showindex.data != null &&
                                //                   showindex.data.isNotEmpty &&
                                //                   showindex.index != -1)
                                //               ? Column(
                                //                   crossAxisAlignment:
                                //                       CrossAxisAlignment
                                //                           .stretch,
                                //                   children: [
                                //                     Container(
                                //                       height: 52,
                                //                       margin: const EdgeInsets
                                //                               .symmetric(
                                //                           horizontal: 10),
                                //                       decoration: BoxDecoration(
                                //                           borderRadius:
                                //                               BorderRadius
                                //                                   .circular(5),
                                //                           color: kWhiteColor),
                                //                       child: ListView.builder(
                                //                         scrollDirection:
                                //                             Axis.horizontal,
                                //                         shrinkWrap: true,
                                //                         itemCount:
                                //                             tabList.length,
                                //                         itemBuilder:
                                //                             (context, index) {
                                //                           return GestureDetector(
                                //                             child: Container(
                                //                               height: 52,
                                //                               width: MediaQuery.of(
                                //                                           context)
                                //                                       .size
                                //                                       .width *
                                //                                   0.3,
                                //                               child: Stack(
                                //                                 children: [
                                //                                   Align(
                                //                                     alignment:
                                //                                         Alignment
                                //                                             .center,
                                //                                     child: Text(
                                //                                         '${tabList[index].tabString}',
                                //                                         style: TextStyle(
                                //                                             color: (tabList[index].identifier == showindex.index)
                                //                                                 ? kMainColor
                                //                                                 : kMainTextColor,
                                //                                             fontSize:
                                //                                                 14)),
                                //                                   ),
                                //                                   Align(
                                //                                     alignment:
                                //                                         Alignment
                                //                                             .bottomCenter,
                                //                                     child:
                                //                                         Divider(
                                //                                       thickness:
                                //                                           1.5,
                                //                                       height:
                                //                                           1.5,
                                //                                       color: (tabList[index].identifier ==
                                //                                               showindex.index)
                                //                                           ? kMainColor
                                //                                           : kWhiteColor,
                                //                                     ),
                                //                                   )
                                //                                 ],
                                //                               ),
                                //                             ),
                                //                             onTap: () {
                                //                               // setState(() {
                                //                               //   // selectTabt = tabList[index].identifier;
                                //                               // });
                                //                               print(showindex
                                //                                   .index);
                                //                               print(tabList[
                                //                                       index]
                                //                                   .identifier);
                                //                               trndProvider.hitTopRecentNewDealPro(
                                //                                   tabDataList[tabList[
                                //                                               index]
                                //                                           .identifier]
                                //                                       .data,
                                //                                   tabList[index]
                                //                                       .identifier);
                                //                             },
                                //                             behavior:
                                //                                 HitTestBehavior
                                //                                     .opaque,
                                //                           );
                                //                         },
                                //                       ),
                                //                     ),
                                //                     BlocBuilder<A2CartSnap,
                                //                             AddtoCartB>(
                                //                         builder: (_, dVal) {
                                //                       return ListView.builder(
                                //                           itemCount: showindex
                                //                               .data.length,
                                //                           shrinkWrap: true,
                                //                           primary: false,
                                //                           physics:
                                //                               NeverScrollableScrollPhysics(),
                                //                           itemBuilder:
                                //                               (context, index) {
                                //                             int qty = 0;
                                //                             int selectedIndexd =
                                //                                 0;
                                //                             if (widget.cartItemd !=
                                //                                     null &&
                                //                                 widget.cartItemd
                                //                                         .length >
                                //                                     0) {
                                //                               int indd = widget
                                //                                   .cartItemd
                                //                                   .indexOf(CartItemData(
                                //                                       varient_id:
                                //                                           '${showindex.data[index].varientId}'));
                                //                               if (indd >= 0) {
                                //                                 qty = widget
                                //                                     .cartItemd[
                                //                                         indd]
                                //                                     .qty;
                                //                               }
                                //                             }

                                //                             int iddV = showindex
                                //                                 .data[index]
                                //                                 .varients
                                //                                 .indexOf(ProductVarient(
                                //                                     varientId: showindex
                                //                                         .data[
                                //                                             index]
                                //                                         .varientId));
                                //                             if (iddV >= 0) {
                                //                               selectedIndexd =
                                //                                   iddV;
                                //                             }
                                //                             print(
                                //                                 'id = $selectedIndexd, ${showindex.data[index].varientId}');

                                //                             return GestureDetector(
                                //                               onTap: () {
                                //                                 // int idd = wishModel.indexOf(WishListDataModel('', '',
                                //                                 //     '${listModel.searchdata[index].varientId}', '', '', '', '', '', '', '', '', '', '','',''));
                                //                                 Navigator.pushNamed(
                                //                                     context,
                                //                                     PageRoutes
                                //                                         .product,
                                //                                     arguments: {
                                //                                       'pdetails':
                                //                                           showindex
                                //                                               .data[index],
                                //                                       'storedetails': widget
                                //                                           .locModel
                                //                                           .storeFinderData,
                                //                                       'isInWish':
                                //                                           false,
                                //                                     });
                                //                               },
                                //                               behavior:
                                //                                   HitTestBehavior
                                //                                       .opaque,
                                //                               child: Container(
                                //                                 decoration: BoxDecoration(
                                //                                     color: Color(
                                //                                         0xffffffff),
                                //                                     borderRadius:
                                //                                         BorderRadius.circular(
                                //                                             5)),
                                //                                 margin: const EdgeInsets
                                //                                         .symmetric(
                                //                                     horizontal:
                                //                                         10,
                                //                                     vertical:
                                //                                         10),
                                //                                 child: Row(
                                //                                   mainAxisAlignment:
                                //                                       MainAxisAlignment
                                //                                           .center,
                                //                                   crossAxisAlignment:
                                //                                       CrossAxisAlignment
                                //                                           .center,
                                //                                   children: [
                                //                                     Container(
                                //                                       width:
                                //                                           120,
                                //                                       child:
                                //                                           Stack(
                                //                                         fit: StackFit
                                //                                             .passthrough,
                                //                                         children: [
                                //                                           Align(
                                //                                               alignment: Alignment.center,
                                //                                               child: Container(
                                //                                                 height: 100,
                                //                                                 child: Image.network(
                                //                                                   '${showindex.data[index].productImage}',
                                //                                                   fit: BoxFit.cover,
                                //                                                 ),
                                //                                                 // Image.asset(
                                //                                                 //   'assets/ProductImages/Cauliflower.png',
                                //                                                 //   fit: BoxFit.cover,
                                //                                                 // ),
                                //                                               )),
                                //                                           Visibility(
                                //                                             visible: (int.parse('${showindex.data[index].stock}') > 0)
                                //                                                 ? false
                                //                                                 : true,
                                //                                             child:
                                //                                                 Positioned.fill(
                                //                                               child: Container(
                                //                                                 alignment: Alignment.center,
                                //                                                 decoration: BoxDecoration(color: kButtonBorderColor.withOpacity(0.5), borderRadius: BorderRadius.circular(5)),
                                //                                                 child: Container(
                                //                                                   decoration: BoxDecoration(color: kWhiteColor, borderRadius: BorderRadius.circular(5)),
                                //                                                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                //                                                   child: Text(
                                //                                                     locale.outstock,
                                //                                                     style: TextStyle(
                                //                                                       color: kMainTextColor,
                                //                                                       fontSize: 11,
                                //                                                     ),
                                //                                                   ),
                                //                                                 ),
                                //                                               ),
                                //                                             ),
                                //                                           ),
                                //                                           Align(
                                //                                             alignment:
                                //                                                 Alignment.topRight,
                                //                                             child:
                                //                                                 Padding(
                                //                                               padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                //                                               child: Row(
                                //                                                 children: [
                                //                                                   ((((double.parse('${showindex.data[index].mrp}') - double.parse('${showindex.data[index].price}')) / double.parse('${showindex.data[index].mrp}')) * 100) > 0)
                                //                                                       ? Container(
                                //                                                           padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1.5),
                                //                                                           child: Text(
                                //                                                             '${(((double.parse('${showindex.data[index].mrp}') - double.parse('${showindex.data[index].price}')) / double.parse('${showindex.data[index].mrp}')) * 100).toStringAsFixed(2)} %',
                                //                                                             style: TextStyle(
                                //                                                               color: kWhiteColor,
                                //                                                               fontSize: 10,
                                //                                                             ),
                                //                                                           ),
                                //                                                           decoration: BoxDecoration(color: kMainColor, borderRadius: BorderRadius.circular(3)),
                                //                                                         )
                                //                                                       : SizedBox.shrink(),
                                //                                                   Visibility(
                                //                                                     visible: ('${showindex.data[index].type}' != 'Regular'),
                                //                                                     child: Container(
                                //                                                       alignment: Alignment.center,
                                //                                                       padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1.5),
                                //                                                       margin: const EdgeInsets.only(left: 5),
                                //                                                       child: Text(
                                //                                                         locale.inseason,
                                //                                                         style: TextStyle(
                                //                                                           color: kMainTextColor,
                                //                                                           fontSize: 10,
                                //                                                         ),
                                //                                                       ),
                                //                                                       decoration: BoxDecoration(color: kButtonBorderColor, borderRadius: BorderRadius.circular(3)),
                                //                                                     ),
                                //                                                   )
                                //                                                 ],
                                //                                               ),
                                //                                             ),
                                //                                           ),
                                //                                         ],
                                //                                       ),
                                //                                     ),
                                //                                     Expanded(
                                //                                       child:
                                //                                           Padding(
                                //                                         padding: const EdgeInsets.symmetric(
                                //                                             horizontal:
                                //                                                 5,
                                //                                             vertical:
                                //                                                 5),
                                //                                         child:
                                //                                             Column(
                                //                                           crossAxisAlignment:
                                //                                               CrossAxisAlignment.stretch,
                                //                                           mainAxisAlignment:
                                //                                               MainAxisAlignment.spaceEvenly,
                                //                                           children: [
                                //                                             Text('${showindex.data[index].productName}',
                                //                                                 maxLines: 2,
                                //                                                 style: TextStyle(color: kMainTextColor, fontSize: 15, fontWeight: FontWeight.w700)),
                                //                                             SizedBox(
                                //                                               height: 8,
                                //                                             ),
                                //                                             Row(
                                //                                               children: [
                                //                                                 Expanded(
                                //                                                     child: Column(
                                //                                                   crossAxisAlignment: CrossAxisAlignment.stretch,
                                //                                                   mainAxisAlignment: MainAxisAlignment.start,
                                //                                                   children: [
                                //                                                     Text(locale.ptype, style: TextStyle(color: kLightTextColor, fontSize: 11)),
                                //                                                     Text('${showindex.data[index].type}', style: TextStyle(color: kMainTextColor, fontSize: 13, fontWeight: FontWeight.w400)),
                                //                                                   ],
                                //                                                 )),
                                //                                                 Expanded(
                                //                                                     child: Column(
                                //                                                   crossAxisAlignment: CrossAxisAlignment.stretch,
                                //                                                   mainAxisAlignment: MainAxisAlignment.start,
                                //                                                   children: [
                                //                                                     Text(locale.pqty, style: TextStyle(color: kLightTextColor, fontSize: 11)),
                                //                                                     (showindex.data[index].varients != null && showindex.data[index].varients.length > 1)
                                //                                                         ? Container(
                                //                                                             height: 20,
                                //                                                             child: DropdownButton<ProductVarient>(
                                //                                                               elevation: 0,
                                //                                                               dropdownColor: kWhiteColor,
                                //                                                               hint: Text('${showindex.data[index].quantity} ${showindex.data[index].unit}', overflow: TextOverflow.clip, maxLines: 1, textAlign: TextAlign.start, style: TextStyle(color: kMainTextColor, fontSize: 11)),
                                //                                                               isExpanded: false,
                                //                                                               icon: Icon(
                                //                                                                 Icons.keyboard_arrow_down,
                                //                                                                 size: 15,
                                //                                                               ),
                                //                                                               underline: Container(
                                //                                                                 height: 0.0,
                                //                                                                 color: kWhiteColor,
                                //                                                               ),
                                //                                                               items: showindex.data[index].varients.map((value) {
                                //                                                                 return DropdownMenuItem<ProductVarient>(
                                //                                                                   value: value,
                                //                                                                   child: Text('${value.quantity} ${value.unit}', textAlign: TextAlign.start, overflow: TextOverflow.clip, style: TextStyle(color: kLightTextColor, fontSize: 11)),
                                //                                                                 );
                                //                                                               }).toList(),
                                //                                                               onChanged: (value) {
                                //                                                                 int iddV = showindex.data[index].varients.indexOf(ProductVarient(varientId: value.varientId));
                                //                                                                 if (iddV >= 0) {
                                //                                                                   setState(() {
                                //                                                                     selectedIndexd = iddV;
                                //                                                                     showindex.data[index].varientId = value.varientId;
                                //                                                                     showindex.data[index].price = value.price;
                                //                                                                     showindex.data[index].mrp = value.mrp;
                                //                                                                     showindex.data[index].quantity = value.quantity;
                                //                                                                     showindex.data[index].unit = value.unit;
                                //                                                                     showindex.data[index].stock = value.stock;
                                //                                                                   });
                                //                                                                 }
                                //                                                                 // print(value);
                                //                                                                 // print(iddV);
                                //                                                                 // print(selectedIndexd);
                                //                                                                 // print(listModel.searchdata[index].varientId);
                                //                                                                 // print(listModel.searchdata[index].price);
                                //                                                                 // print(listModel.searchdata[index].mrp);
                                //                                                                 // print(listModel.searchdata[index].quantity);
                                //                                                                 // print(listModel.searchdata[index].unit);
                                //                                                               },
                                //                                                             ),
                                //                                                           )
                                //                                                         : Text('${showindex.data[index].quantity} ${showindex.data[index].unit}', overflow: TextOverflow.clip, maxLines: 1, textAlign: TextAlign.start, style: TextStyle(color: kMainTextColor, fontSize: 11)),
                                //                                                     // Row(
                                //                                                     //   children: [
                                //                                                     //     Text('${showindex.data[index].quantity} ${showindex.data[index].unit}',
                                //                                                     //         overflow: TextOverflow.ellipsis,
                                //                                                     //         style: TextStyle(
                                //                                                     //             color: kMainTextColor,
                                //                                                     //             fontSize: 13,
                                //                                                     //             fontWeight:
                                //                                                     //             FontWeight.w400)),
                                //                                                     //     SizedBox(
                                //                                                     //       width: 5,
                                //                                                     //     ),
                                //                                                     //     Icon(
                                //                                                     //       Icons.keyboard_arrow_down,
                                //                                                     //       size: 15,
                                //                                                     //     )
                                //                                                     //   ],
                                //                                                     // )
                                //                                                   ],
                                //                                                 )),
                                //                                               ],
                                //                                             ),
                                //                                             SizedBox(
                                //                                               height: 10,
                                //                                             ),
                                //                                             Row(
                                //                                               children: [
                                //                                                 Expanded(
                                //                                                     child: Column(
                                //                                                   crossAxisAlignment: CrossAxisAlignment.start,
                                //                                                   mainAxisAlignment: MainAxisAlignment.start,
                                //                                                   children: [
                                //                                                     Visibility(
                                //                                                       visible: ('${showindex.data[index].price}' == '${showindex.data[index].mrp}') ? false : true,
                                //                                                       child: Text('$apCurrency ${showindex.data[index].mrp}', style: TextStyle(color: kLightTextColor, fontSize: 14, decoration: TextDecoration.lineThrough)),
                                //                                                     ),
                                //                                                     Text('$apCurrency ${showindex.data[index].price}', style: TextStyle(color: kMainColor, fontSize: 16, fontWeight: FontWeight.w400)),
                                //                                                   ],
                                //                                                 )),
                                //                                                 Expanded(
                                //                                                   child: Visibility(
                                //                                                     visible: (int.parse('${showindex.data[index].stock}') > 0) ? true : false,
                                //                                                     child: Stack(
                                //                                                       children: [
                                //                                                         Align(
                                //                                                           child: qty > 0
                                //                                                               ? Container(
                                //                                                                   height: 33,
                                //                                                                   alignment: Alignment.center,
                                //                                                                   decoration: BoxDecoration(color: kMainColor.withOpacity(0.4), borderRadius: BorderRadius.circular(30)),
                                //                                                                   padding: const EdgeInsets.symmetric(horizontal: 5),
                                //                                                                   child: Row(
                                //                                                                     mainAxisAlignment: MainAxisAlignment.center,
                                //                                                                     children: [
                                //                                                                       buildIconButton(Icons.remove, context, onpressed: () {
                                //                                                                         if (qty > 0 && dVal.status == false) {
                                //                                                                           a2cartSnap.hitSnap(int.parse('${showindex.data[index].productId}'), true);
                                //                                                                           addtocart2('${showindex.data[index].storeId}', '${showindex.data[index].varientId}', (qty - 1), '0', context, 0);
                                //                                                                         } else {
                                //                                                                           Toast.show(locale.pcurprogress, context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                                //                                                                         }
                                //                                                                       }),
                                //                                                                       SizedBox(
                                //                                                                         width: 8,
                                //                                                                       ),
                                //                                                                       (dVal.status == true && '${dVal.prodId}' == '${showindex.data[index].productId}')
                                //                                                                           ? SizedBox(
                                //                                                                               height: 10,
                                //                                                                               width: 10,
                                //                                                                               child: CircularProgressIndicator(
                                //                                                                                 strokeWidth: 1,
                                //                                                                               ),
                                //                                                                             )
                                //                                                                           : Text('x$qty', style: Theme.of(context).textTheme.subtitle1),
                                //                                                                       SizedBox(
                                //                                                                         width: 8,
                                //                                                                       ),
                                //                                                                       buildIconButton(Icons.add, context, type: 1, onpressed: () {
                                //                                                                         if ((qty + 1) <= int.parse('${showindex.data[index].stock}') && dVal.status == false) {
                                //                                                                           a2cartSnap.hitSnap(int.parse('${showindex.data[index].productId}'), true);
                                //                                                                           addtocart2('${showindex.data[index].storeId}', '${showindex.data[index].varientId}', (qty + 1), '0', context, 0);
                                //                                                                         } else {
                                //                                                                           if (dVal.status == false) {
                                //                                                                             Toast.show(locale.outstock2, context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                                //                                                                           } else {
                                //                                                                             Toast.show(locale.pcurprogress, context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                                //                                                                           }
                                //                                                                         }
                                //                                                                       }),
                                //                                                                     ],
                                //                                                                   ),
                                //                                                                 )
                                //                                                               : (dVal.status == true && '${dVal.prodId}' == '${showindex.data[index].productId}')
                                //                                                                   ? SizedBox(
                                //                                                                       height: 10,
                                //                                                                       width: 10,
                                //                                                                       child: CircularProgressIndicator(
                                //                                                                         strokeWidth: 1,
                                //                                                                       ),
                                //                                                                     )
                                //                                                                   : MaterialButton(
                                //                                                                       onPressed: () {
                                //                                                                         if (int.parse('${showindex.data[index].stock}') > 0 && dVal.status == false) {
                                //                                                                           a2cartSnap.hitSnap(int.parse('${showindex.data[index].productId}'), true);
                                //                                                                           addtocart2('${showindex.data[index].storeId}', '${showindex.data[index].varientId}', (qty + 1), '0', context, 0);
                                //                                                                         } else {
                                //                                                                           if (dVal.status == false) {
                                //                                                                             Toast.show(locale.outstock2, context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                                //                                                                           } else {
                                //                                                                             Toast.show(locale.pcurprogress, context, duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
                                //                                                                           }
                                //                                                                         }
                                //                                                                       },
                                //                                                                       splashColor: kMainColor,
                                //                                                                       color: kMainColor.withOpacity(0.4),
                                //                                                                       child: Row(
                                //                                                                         children: [
                                //                                                                           Expanded(
                                //                                                                               child: Text(
                                //                                                                             'ADD',
                                //                                                                             textAlign: TextAlign.center,
                                //                                                                             style: TextStyle(color: kMainColor, fontSize: 15, fontWeight: FontWeight.w600),
                                //                                                                           )),
                                //                                                                           Icon(Icons.add_sharp, size: 15, color: kMainColor)
                                //                                                                         ],
                                //                                                                       ),
                                //                                                                       elevation: 0,
                                //                                                                       height: 33,
                                //                                                                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                //                                                                     ),
                                //                                                           alignment: Alignment.bottomCenter,
                                //                                                         )
                                //                                                       ],
                                //                                                     ),
                                //                                                   ),
                                //                                                 ),
                                //                                               ],
                                //                                             ),
                                //                                           ],
                                //                                         ),
                                //                                       ),
                                //                                     )
                                //                                   ],
                                //                                 ),
                                //                               ),
                                //                             );
                                //                           });
                                //                     }),
                                //                     Padding(
                                //                       padding: const EdgeInsets
                                //                               .symmetric(
                                //                           horizontal: 20,
                                //                           vertical: 10),
                                //                       child: MaterialButton(
                                //                         onPressed: () {
                                //                           int typed;
                                //                           if ('${tabDataList[selectTabt].type}'
                                //                                   .toUpperCase() ==
                                //                               'RECENT SELLING') {
                                //                             typed = 1;
                                //                           } else if ('${tabDataList[selectTabt].type}'
                                //                                   .toUpperCase() ==
                                //                               'TOP SELLING') {
                                //                             typed = 0;
                                //                           } else if ('${tabDataList[selectTabt].type}'
                                //                                   .toUpperCase() ==
                                //                               'WHATS NEW') {
                                //                             typed = 2;
                                //                           } else if ('${tabDataList[selectTabt].type}'
                                //                                   .toUpperCase() ==
                                //                               'DEAL PRODUCTS') {
                                //                             typed = 3;
                                //                           }
                                //                           Navigator.pushNamed(
                                //                               context,
                                //                               PageRoutes
                                //                                   .viewall,
                                //                               arguments: {
                                //                                 'title':
                                //                                     tabDataList[
                                //                                             selectTabt]
                                //                                         .type,
                                //                                 'type': typed,
                                //                                 'storedetail': widget
                                //                                     .locModel
                                //                                     .storeFinderData,
                                //                               });
                                //                         },
                                //                         splashColor: kMainColor,
                                //                         color: kMainColor,
                                //                         child: Text(
                                //                           'View All Popular Products',
                                //                           textAlign:
                                //                               TextAlign.center,
                                //                           style: TextStyle(
                                //                               color:
                                //                                   kWhiteColor,
                                //                               fontSize: 15,
                                //                               fontWeight:
                                //                                   FontWeight
                                //                                       .w600),
                                //                         ),
                                //                         elevation: 0,
                                //                         height: 45,
                                //                         shape: RoundedRectangleBorder(
                                //                             borderRadius:
                                //                                 BorderRadius
                                //                                     .circular(
                                //                                         30)),
                                //                       ),
                                //                     ),
                                //                   ],
                                //                 )
                                //               : SizedBox.shrink();
                                //         },
                                //         buildWhen: (pre, current) {
                                //           return pre != current;
                                //         },
                                //       )
                                //     : SizedBox.shrink(),
                                const SizedBox(
                                  height: 10,
                                ),

                                SizedBox(
                                  height: 200,
                                  child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Category',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: kMainTextColor,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (context) {
                                                  return ViewAllCategory(
                                                    cats: apiData
                                                        .dataModel.topCat,
                                                  );
                                                }));
                                              },
                                              behavior: HitTestBehavior.opaque,
                                              child: Text(
                                                'View All',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: kMainColor,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Expanded(
                                          // child: ListView(
                                          //   scrollDirection: Axis.horizontal,
                                          //   children: [
                                          //     Padding(
                                          //       padding:
                                          //           const EdgeInsets.all(8.0),
                                          //       child: GestureDetector(
                                          //         onTap: () =>
                                          //             Navigator.of(context)
                                          //                 .push(
                                          //           MaterialPageRoute(
                                          //             builder: (context) =>
                                          //                 SubCategoryPage(
                                          //               cartItemd:
                                          //                   widget.cartItemd,
                                          //               locModel:
                                          //                   widget.locModel,
                                          //             ),
                                          //           ),
                                          //         ),
                                          //         child: const CategoryCard(
                                          //             title:
                                          //                 'Fruits & Vegetables',
                                          //             color: Color.fromRGBO(
                                          //                 79, 130, 50, 1.0),
                                          //             bottomImage:
                                          //                 'assets/CategoryImages/fruit-vegitables-bottom.png',
                                          //             icon:
                                          //                 'assets/CategoryImages/fruits-vegitables.png',
                                          //             bottomImgHeight: 60,
                                          //             iconSize: 65,
                                          //             fontSize: 12),
                                          //       ),
                                          //     ),
                                          //     Padding(
                                          //         padding: EdgeInsets.all(8.0),
                                          //         child: CategoryCard(
                                          //             title:
                                          //                 'Snacks & Branded Foods',
                                          //             color: Color.fromRGBO(
                                          //                 143, 41, 52, 1.0),
                                          //             bottomImage:
                                          //                 'assets/CategoryImages/snacks-branded-food-bottom.png',
                                          //             icon:
                                          //                 'assets/CategoryImages/snacks-branded-food.png',
                                          //             bottomImgHeight: 60,
                                          //             iconSize: 65,
                                          //             fontSize: 12)),
                                          //     Padding(
                                          //         padding: EdgeInsets.all(8.0),
                                          //         child: CategoryCard(
                                          //             title:
                                          //                 'Bakery, Cake & Dairy',
                                          //             color: Color.fromRGBO(
                                          //                 101, 178, 169, 1.0),
                                          //             bottomImage:
                                          //                 'assets/CategoryImages/bakery-cake-dairy-bottom.png',
                                          //             icon:
                                          //                 'assets/CategoryImages/bakery-cake-dairy.png',
                                          //             bottomImgHeight: 60,
                                          //             iconSize: 65,
                                          //             fontSize: 12)),
                                          //     Padding(
                                          //         padding: EdgeInsets.all(8.0),
                                          //         child: CategoryCard(
                                          //             title:
                                          //                 'Food, Grains, Oils & Masala',
                                          //             color: Color.fromRGBO(
                                          //                 185, 78, 117, 1.0),
                                          //             bottomImage:
                                          //                 'assets/CategoryImages/food-grains-oil-masala-bottom.png',
                                          //             icon:
                                          //                 'assets/CategoryImages/food-grain-oil-masala.png',
                                          //             bottomImgHeight: 60,
                                          //             iconSize: 65,
                                          //             fontSize: 12)),
                                          //   ],
                                          // ),
                                          // ListView.builder(
                                          //     itemCount: 5,
                                          //     scrollDirection:
                                          //         Axis.horizontal,
                                          //     itemBuilder:
                                          //         (context, index) {
                                          //       return const Padding(
                                          //           padding:
                                          //               EdgeInsets.all(8.0),
                                          //           child: CategoryCard(
                                          //             title:
                                          //                 'Fruits & Vegetables',
                                          //             color: Color.fromRGBO(
                                          //                 79, 130, 50, 1.0),
                                          //             bottomImage:
                                          //                 'assets/CategoryImages/fruit-vegitables-bottom.png',
                                          //             icon:
                                          //                 'assets/CategoryImages/fruits-vegitables.png',
                                          //           ));
                                          //     })
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      Navigator.of(context)
                                                          .push(
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SubCategoryPage(
                                                        cartItemd:
                                                            widget.cartItemd,
                                                        locModel:
                                                            widget.locModel,
                                                        cat: apiData.dataModel
                                                            .topCat[index],
                                                        appBarImage:
                                                            staticImage[index],
                                                      ),
                                                    ),
                                                  ),
                                                  child: CategoryCard(
                                                      title: apiData.dataModel
                                                          .topCat[index].title,
                                                      // Color(0xff+apiData.dataModel.topCat[index].iconColor) ??
                                                      color: staticColor[index],
                                                      bottomImage:
                                                          // '$imagebaseUrl1 + ${apiData.dataModel.topCat[index].image.substring(1)}',
                                                          staticImage[index],
                                                      icon: apiData
                                                              .dataModel
                                                              .topCat[index]
                                                              .otherImages ??
                                                          staticIcon[index],
                                                      bottomImgHeight: 60,
                                                      iconSize: 65,
                                                      fontSize: 12),
                                                ),
                                              );
                                            },
                                            itemCount:
                                                apiData.dataModel.topCat.length,
                                          ),
                                        ),
                                      ]),
                                ),

                                // (offers != null && offers.isNotEmpty)
                                //     ? Container(
                                //         margin: const EdgeInsets.symmetric(
                                //             vertical: 10),
                                //         padding: const EdgeInsets.symmetric(
                                //             horizontal: 10, vertical: 10),
                                //         decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(5),
                                //             color: kWhiteColor),
                                //         child: Column(
                                //           children: [
                                //             Row(
                                //               mainAxisAlignment:
                                //                   MainAxisAlignment
                                //                       .spaceBetween,
                                //               children: [
                                //                 Text(
                                //                   'OFFER ZONE',
                                //                   textAlign: TextAlign.center,
                                //                   style: TextStyle(
                                //                       color: kMainTextColor,
                                //                       fontSize: 13,
                                //                       fontWeight:
                                //                           FontWeight.w300),
                                //                 ),
                                //                 GestureDetector(
                                //                   onTap: () {
                                //                     if (widget.locModel
                                //                             .storeFinderData !=
                                //                         null) {
                                //                       Navigator.pushNamed(
                                //                           context,
                                //                           PageRoutes
                                //                               .offerpage,
                                //                           arguments: {
                                //                             'store_id':
                                //                                 '${widget.locModel.storeFinderData.store_id}',
                                //                             'cart_id': '--'
                                //                           });
                                //                     }
                                //                   },
                                //                   behavior:
                                //                       HitTestBehavior.opaque,
                                //                   child: Text(
                                //                     'View All',
                                //                     textAlign:
                                //                         TextAlign.center,
                                //                     style: TextStyle(
                                //                         color: kMainColor,
                                //                         fontSize: 13,
                                //                         fontWeight:
                                //                             FontWeight.w300),
                                //                   ),
                                //                 )
                                //               ],
                                //             ),
                                //             SizedBox(
                                //               height: 8,
                                //             ),
                                //             Divider(
                                //               thickness: 1.5,
                                //               height: 1.5,
                                //               color: kButtonBorderColor
                                //                   .withOpacity(0.5),
                                //             ),
                                //             SizedBox(
                                //               height: 10,
                                //             ),
                                //             CarouselSlider(
                                //               options: CarouselOptions(
                                //                   height: 150.0,
                                //                   viewportFraction: 0.90,
                                //                   onPageChanged:
                                //                       (index, reason) {
                                //                     // setState(() {
                                //                     //   pageIndex = index;
                                //                     pageSnap.emit(index);
                                //                     // });
                                //                     // print(index);
                                //                   },
                                //                   autoPlay: true),
                                //               items: offers.map((i) {
                                //                 return Builder(
                                //                   builder:
                                //                       (BuildContext context) {
                                //                     return Container(
                                //                       width: MediaQuery.of(
                                //                                   context)
                                //                               .size
                                //                               .width *
                                //                           0.9,
                                //                       margin: const EdgeInsets
                                //                               .symmetric(
                                //                           horizontal: 10),
                                //                       // padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                //                       decoration: BoxDecoration(
                                //                           borderRadius:
                                //                               BorderRadius
                                //                                   .circular(
                                //                                       5),
                                //                           color: kMainColor,
                                //                           image: DecorationImage(
                                //                               image: AssetImage(
                                //                                   'assets/offerback.png'),
                                //                               fit: BoxFit
                                //                                   .fill)),
                                //                       child: Stack(
                                //                         children: [
                                //                           Align(
                                //                             alignment:
                                //                                 Alignment
                                //                                     .topCenter,
                                //                             child: Padding(
                                //                               padding:
                                //                                   const EdgeInsets
                                //                                           .all(
                                //                                       8.0),
                                //                               child: Text(
                                //                                   i
                                //                                       .coupon_description,
                                //                                   style: TextStyle(
                                //                                       color:
                                //                                           kMainTextColor,
                                //                                       letterSpacing:
                                //                                           1.3,
                                //                                       wordSpacing:
                                //                                           1.0,
                                //                                       fontSize:
                                //                                           13)),
                                //                             ),
                                //                           ),
                                //                           Align(
                                //                             alignment:
                                //                                 Alignment
                                //                                     .center,
                                //                             child: Padding(
                                //                               padding:
                                //                                   const EdgeInsets
                                //                                           .all(
                                //                                       10.0),
                                //                               child: Text(
                                //                                   '${i.coupon_code}',
                                //                                   style: TextStyle(
                                //                                       color:
                                //                                           kMainTextColor,
                                //                                       letterSpacing:
                                //                                           2.5,
                                //                                       fontWeight:
                                //                                           FontWeight
                                //                                               .w600,
                                //                                       fontSize:
                                //                                           25)),
                                //                             ),
                                //                           ),
                                //                           Positioned(
                                //                             right: 5,
                                //                             bottom: 10,
                                //                             child: Container(
                                //                               padding:
                                //                                   const EdgeInsets
                                //                                           .all(
                                //                                       8.0),
                                //                               decoration:
                                //                                   BoxDecoration(
                                //                                       color: kMainColor.withOpacity(
                                //                                           0.3),
                                //                                       borderRadius:
                                //                                           BorderRadius.only(
                                //                                         topLeft:
                                //                                             Radius.circular(20),
                                //                                         bottomLeft:
                                //                                             Radius.circular(20),
                                //                                       )),
                                //                               child: Text(
                                //                                   'Min Pur. - $apCurrency ${i.cart_value}',
                                //                                   style: TextStyle(
                                //                                       color:
                                //                                           kMainTextColor,
                                //                                       letterSpacing:
                                //                                           0.3,
                                //                                       fontSize:
                                //                                           16)),
                                //                             ),
                                //                           )
                                //                         ],
                                //                       ),
                                //                     );
                                //                   },
                                //                 );
                                //               }).toList(),
                                //             ),
                                //             Padding(
                                //               padding:
                                //                   const EdgeInsets.symmetric(
                                //                       vertical: 8.0),
                                //               child: BlocBuilder<
                                //                       PageSnapReview, int>(
                                //                   builder: (context, pageI) {
                                //                 return Container(
                                //                   height: 20,
                                //                   alignment: Alignment.center,
                                //                   child: ListView.separated(
                                //                     shrinkWrap: true,
                                //                     scrollDirection:
                                //                         Axis.horizontal,
                                //                     itemCount: offers.length,
                                //                     itemBuilder:
                                //                         (context, index) {
                                //                       return Padding(
                                //                         padding:
                                //                             const EdgeInsets
                                //                                 .all(2.0),
                                //                         child: Card(
                                //                           // type: MaterialType.circle,
                                //                           color: (pageI ==
                                //                                   index)
                                //                               ? kMainColor
                                //                               : kCardBackgroundColor,
                                //                           shape: RoundedRectangleBorder(
                                //                               borderRadius:
                                //                                   BorderRadius
                                //                                       .circular(
                                //                                           10)),
                                //                           child: Container(
                                //                             height: (pageI ==
                                //                                     index)
                                //                                 ? 15
                                //                                 : 10,
                                //                             width: (pageI ==
                                //                                     index)
                                //                                 ? 15
                                //                                 : 10,
                                //                             decoration:
                                //                                 BoxDecoration(
                                //                               shape: BoxShape
                                //                                   .circle,
                                //                               color: (pageI ==
                                //                                       index)
                                //                                   ? kMainColor
                                //                                   : kCardBackgroundColor,
                                //                               // borderRadius: BorderRadius.circular(10)
                                //                               // shape: BoxShape.circle,
                                //                               // border: Border.all(color: (index==pageIndex)?kMainColor:kLightTextColor)
                                //                             ),
                                //                           ),
                                //                         ),
                                //                       );
                                //                     },
                                //                     separatorBuilder:
                                //                         (context, index) {
                                //                       return SizedBox(
                                //                         width: 5,
                                //                       );
                                //                     },
                                //                   ),
                                //                 );
                                //               }),
                                //             ),
                                //           ],
                                //         ),
                                //       )
                                //     : SizedBox.shrink(),
                                const SizedBox(
                                  height: 10,
                                ),
                                (apiData.dataModel.subProdList != null &&
                                        apiData
                                            .dataModel.subProdList.isNotEmpty)
                                    ? ProductsCardWithTitle(
                                        title: 'Subscribe Products',
                                        catP: cateP,
                                        locale: locale,
                                        locModel: widget.locModel,
                                        count: apiData
                                            .dataModel.subProdList.length,
                                        data: apiData.dataModel.subProdList,
                                        isAlwaysSubscribe: true)
                                    : const SizedBox.shrink(),
                                const SizedBox(
                                  height: 15,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: ImageSlideshow(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: 200,
                                    initialPage: 0,
                                    indicatorColor: kNavigationButtonColor,
                                    indicatorBackgroundColor: kWhiteColor,
                                    children: apiData.dataModel.banner
                                        .map(
                                          (sa.BannerDataModel dataModel) =>
                                              ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  '$imagebaseUrl1${dataModel.bannerImage.substring(1)}',
                                              placeholder: (context, url) =>
                                                  Align(
                                                widthFactor: 50,
                                                heightFactor: 50,
                                                alignment: Alignment.center,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  width: 50,
                                                  height: 180,
                                                  child: const Center(
                                                      child:
                                                          CircularProgressIndicator()),
                                                ),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Center(
                                                child: Image.asset(
                                                  'assets/HomeBanner/no-icon.png',
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onPageChanged: (value) {},
                                    autoPlayInterval: 3000,
                                    isLoop: true,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                (apiData.dataModel.spotlight != null &&
                                        apiData.dataModel.spotlight.isNotEmpty)
                                    ? ProductsCardWithTitle(
                                        title: 'Spotlight Products',
                                        catP: cateP,
                                        locale: locale,
                                        locModel: widget.locModel,
                                        count:
                                            apiData.dataModel.spotlight.length,
                                        data: apiData.dataModel.spotlight,
                                      )
                                    : const SizedBox.shrink(),
                                (apiData.dataModel.spotlight != null &&
                                        apiData.dataModel.spotlight.isNotEmpty)
                                    ? const SizedBox(
                                        height: 15,
                                      )
                                    : const SizedBox.shrink(),
                                (apiData.dataModel.topselling != null &&
                                        apiData.dataModel.topselling.isNotEmpty)
                                    ? ProductsCardWithTitle(
                                        title: 'Top Selling',
                                        catP: cateP,
                                        locale: locale,
                                        locModel: widget.locModel,
                                        count:
                                            apiData.dataModel.topselling.length,
                                        data: apiData.dataModel.topselling,
                                      )
                                    : const SizedBox.shrink(),
                                (apiData.dataModel.topselling != null &&
                                        apiData.dataModel.topselling.isNotEmpty)
                                    ? const SizedBox(
                                        height: 15,
                                      )
                                    : const SizedBox.shrink(),
                                (apiData.dataModel.recentselling != null &&
                                        apiData
                                            .dataModel.recentselling.isNotEmpty)
                                    ? ProductsCardWithTitle(
                                        title: 'Recent Selling',
                                        catP: cateP,
                                        locale: locale,
                                        locModel: widget.locModel,
                                        count: apiData
                                            .dataModel.recentselling.length,
                                        data: apiData.dataModel.recentselling,
                                      )
                                    : const SizedBox.shrink(),
                                (apiData.dataModel.recentselling != null &&
                                        apiData
                                            .dataModel.recentselling.isNotEmpty)
                                    ? const SizedBox(
                                        height: 15,
                                      )
                                    : const SizedBox.shrink(),
                                (apiData.dataModel.whatsnew != null &&
                                        apiData.dataModel.whatsnew.isNotEmpty)
                                    ? ProductsCardWithTitle(
                                        title: 'Whats New',
                                        catP: cateP,
                                        locale: locale,
                                        locModel: widget.locModel,
                                        count:
                                            apiData.dataModel.whatsnew.length,
                                        data: apiData.dataModel.whatsnew,
                                      )
                                    : const SizedBox.shrink(),
                                (apiData.dataModel.whatsnew != null &&
                                        apiData.dataModel.whatsnew.isNotEmpty)
                                    ? const SizedBox(
                                        height: 15,
                                      )
                                    : const SizedBox.shrink(),
                                (apiData.dataModel.dealproduct != null &&
                                        apiData
                                            .dataModel.dealproduct.isNotEmpty)
                                    ? ProductsCardWithTitle(
                                        title: 'Deal Products',
                                        catP: cateP,
                                        locale: locale,
                                        locModel: widget.locModel,
                                        count: apiData
                                            .dataModel.dealproduct.length,
                                        data: apiData.dataModel.dealproduct,
                                      )
                                    : const SizedBox.shrink(),
                                const SizedBox(height: 45),
                              ],
                            ),
                          );
                        } else {
                          return Container(
                            alignment: Alignment.center,
                            child: Text(
                              (apiData.dataModel != null &&
                                      apiData.dataModel.message != null)
                                  ? apiData.dataModel.message
                                  : locale.aa5,
                              textAlign: TextAlign.center,
                            ),
                          );
                        }
                      }
                    },
                    buildWhen: (pre, current) {
                      return pre != current;
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: BlocBuilder<ProfileProvider, AppInfoModel>(
      //     builder: (context, signModel) {
      //   if (signModel != null) {
      //     return FloatingActionButton(
      //       heroTag: "btn1",
      //       onPressed: () {},
      //       backgroundColor: kWhiteColor,
      //       // backgroundColor: const Color.fromRGBO(246, 196, 88, 1.0),
      //       child: Image.asset('assets/ic_floating.png'),
      //     );
      //     // return SpeedDial(
      //     //     childMargin: EdgeInsets.only(bottom: 30, right: 10),
      //     //     animatedIcon: AnimatedIcons.menu_close,
      //     //     // animatedIconColor:Colors.white,
      //     //     animatedIconTheme: IconThemeData(size: 22.0),
      //     //     closeManually: false,
      //     //     curve: Curves.bounceIn,
      //     //     overlayColor: Colors.white,
      //     //     overlayOpacity: 0.5,
      //     //     onOpen: () => print('OPENING DIAL'),
      //     //     onClose: () => print('DIAL CLOSED'),
      //     //     tooltip: 'Speed Dial',
      //     //     heroTag: 'speed-dial-hero-tag',
      //     //     backgroundColor: kMainColor,
      //     //     foregroundColor: Colors.white,
      //     //     elevation: 8.0,
      //     //     shape: CircleBorder(),
      //     //     children: [
      //     //       SpeedDialChild(
      //     //           child: Icon(Icons.share, color: Colors.white),
      //     //           backgroundColor: kMainColor,
      //     //           labelStyle: TextStyle(fontSize: 18.0),
      //     //           onTap: () {
      //     //             share(locale.shareheading, locale.sharetext, signModel);
      //     //           }),
      //     //       SpeedDialChild(
      //     //         child: Icon(Icons.rate_review, color: Colors.white),
      //     //         backgroundColor: kMainColor,
      //     //         onTap: () {
      //     //           launchUrl(signModel);
      //     //         },
      //     //       ),
      //     //       SpeedDialChild(
      //     //         child: Icon(Icons.call, color: Colors.white),
      //     //         backgroundColor: kMainColor,
      //     //         onTap: () {
      //     //           callNumberStore(
      //     //               widget.locModel.storeFinderData.store_number);
      //     //         },
      //     //       ),
      //     //       SpeedDialChild(
      //     //         child: ImageIcon(
      //     //             AssetImage(
      //     //               'assets/whatsapp.png',
      //     //             ),
      //     //             size: 20,
      //     //             color: kWhiteColor),
      //     //         backgroundColor: kMainColor,
      //     //         onTap: () {
      //     //           openWhatsApp(widget.locModel.storeFinderData.store_number,
      //     //               locale.nowhatsappinstalled, context);
      //     //         },
      //     //       ),
      //     //     ]);
      //   } else {
      //     return SizedBox.shrink();
      //   }
      // })
    );
  }

  Future<void> share(
      String share, String sharetext, AppInfoModel modelApp) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var applink =
        Platform.isIOS ? modelApp.iosAppLink : modelApp.androidAppLink;
    await FlutterShare.share(
        title: appname,
        text:
            '${modelApp.refertext}\n$sharetext ${prefs.getString('refferal_code')}.',
        linkUrl: '$applink',
        chooserTitle: '$share ${appname}');
  }

  Future<void> launchUrl(AppInfoModel modelApp) async {
    var applink =
        Platform.isIOS ? modelApp.iosAppLink : modelApp.androidAppLink;
    if (await canLaunch(applink)) {
      await launch(applink);
    } else {
      throw 'Could not launch $applink';
    }
  }

  void callNumberStore(store_number) async {
    await launch('tel:$store_number');
  }

  void openWhatsApp(
      store_number, String nowhatsappinstalled, BuildContext context) async {
    String urlk = "https://wa.me/$store_number";
    var dd = await launch(urlk);
    print(dd);
  }

  Widget buildIconButton(IconData icon, BuildContext context,
      {Function onpressed, int type}) {
    return GestureDetector(
      onTap: () {
        onpressed();
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 25,
        height: 25,
        alignment: Alignment.center,
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(20),
        //     border: Border.all(color: type==1?kMainColor:kRedColor, width: 0)),
        child: Icon(
          icon,
          color: type == 1 ? kMainColor : kRedColor,
          size: 16,
        ),
      ),
    );
  }

  //
  // Future<List<TopCategoryDataModel>> getCategoryFuture() async {
  //   return await _memoizer.runOnce(() async {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     Response bodyRes = await http.post(topCatUri, body: {
  //       'store_id': '$store_id'
  //     }, headers: {
  //       // 'Content-Type': 'application/x-www-form-urlencoded',
  //       'Authorization': 'Bearer ${prefs.getString('accesstoken')}'
  //     });
  //     TopCategoryModel cateData =
  //         TopCategoryModel.fromJson(jsonDecode(bodyRes.body));
  //     print('io  - - > ${cateData.data}');
  //     return cateData.data;
  //   });
  // }
  //
  // Future<List<BannerDataModel>> getBannerFuture() async {
  //   return await _memoizer2.runOnce(() async {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     Response bodyRes = await http.post(storeBannerUri, body: {
  //       'store_id': '$store_id'
  //     }, headers: {
  //       // 'Content-Type': 'application/x-www-form-urlencoded',
  //       'Authorization': 'Bearer ${prefs.getString('accesstoken')}'
  //     });
  //     BannerModel cateData = BannerModel.fromJson(jsonDecode(bodyRes.body));
  //     print('io  - - > ${cateData.data}');
  //     return cateData.data;
  //   });
  //
  //   // return await _memoizer.runOnce(() async {
  //   //
  //   // });
  // }

  void addtocart2(String storeid, String varientid, dynamic qnty,
      String special, BuildContext context, int index) async {
    var locale = AppLocalizations.of(context);
    // setState(() {
    //   progressadd = true;
    // });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('islogin') && preferences.getBool('islogin')) {
      if (preferences.getString('block') == '1') {
        a2cartSnap.hitSnap(-1, false);
        // setState(() {
        //   progressadd = false;
        // });
        Toast.show(locale.blockmsg, context,
            gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
      } else {
        var http = Client();
        http.post(addToCartUri, body: {
          'user_id': '${preferences.getInt('user_id')}',
          'qty': '${int.parse('$qnty')}',
          'store_id': '${int.parse(storeid)}',
          'varient_id': '${int.parse(varientid)}',
          'special': special,
        }, headers: {
          'Authorization': 'Bearer ${preferences.getString('accesstoken')}'
        }).then((value) {
          print('cart add${value.body}');
          a2cartSnap.hitSnap(-1, false);
          if (value.statusCode == 200) {
            AddToCartMainModel data1 =
                AddToCartMainModel.fromJson(jsonDecode(value.body));
            if ('${data1.status}' == '1') {
              cartListPro.emitCartList(data1.cart_items, data1.total_price);
              cartCounterProvider.hitCartCounter(data1.cart_items.length);
            } else {
              cartListPro.emitCartList([], 0.0);
              // _counter = 0;
              cartCounterProvider.hitCartCounter(0);
            }
            Toast.show(data1.message, context,
                gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
          }
          // setState(() {
          //   progressadd = false;
          // });
        }).catchError((e) {
          a2cartSnap.hitSnap(-1, false);
          // setState(() {
          //   progressadd = false;
          // });
          print(e);
        });
      }
    } else {
      a2cartSnap.hitSnap(-1, false);
      // setState(() {
      //   progressadd = false;
      // });
      Toast.show(locale.loginfirst, context,
          gravity: Toast.CENTER, duration: Toast.LENGTH_SHORT);
    }
  }
}
