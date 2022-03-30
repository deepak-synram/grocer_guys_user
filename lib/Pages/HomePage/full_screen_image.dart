// ignore_for_file: avoid_print

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:user/Locale/locales.dart';
import 'package:user/Pages/Other/app_bar.dart';
import 'package:user/Routes/routes.dart';
import 'package:user/Theme/colors.dart';
import 'package:user/providergrocery/cartcountprovider.dart';

class FullScreenView extends StatefulWidget {
  final String image;
  final AppLocalizations locale;

  const FullScreenView({
    Key key,
    @required this.image,
    @required this.locale,
  }) : super(key: key);

  @override
  State<FullScreenView> createState() => _FullScreenViewState();
}

class _FullScreenViewState extends State<FullScreenView> {
  List<String> _listOfImages = [];
  int index1 = 0;

  @override
  void initState() {
    setState(() {
      _listOfImages = [widget.image, widget.image, widget.image];
      index1 = 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        widget: BlocBuilder<CartCountProvider, int>(
            builder: (context, cartCount) => Badge(
                position: BadgePosition.topEnd(top: 5, end: 5),
                padding: const EdgeInsets.all(5),
                animationDuration: const Duration(milliseconds: 300),
                animationType: BadgeAnimationType.slide,
                badgeContent: Text(
                  cartCount.toString(),
                  style: TextStyle(color: kWhiteColor, fontSize: 10),
                ),
                child: IconButton(
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (prefs.containsKey('islogin') &&
                        prefs.getBool('islogin')) {
                      Navigator.pushNamed(context, PageRoutes.cartPage)
                          .then((value) {
                        print('value d');
                        // getCartList();
                      }).catchError((e) {
                        print('dd');
                        // getCartList();
                      });
                      // Navigator.pushNamed(context, PageRoutes.cart)

                    } else {
                      Toast.show(
                        widget.locale.loginfirst,
                        context,
                        gravity: Toast.CENTER,
                        duration: Toast.LENGTH_SHORT,
                      );
                    }
                  },
                  icon: Container(
                      decoration: BoxDecoration(
                        color: kNavigationButtonColor,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.shopping_cart,
                        color: kMainColor,
                      )),
                ))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ImageSlideshow(
              width: MediaQuery.of(context).size.width * 0.8,
              // height: 200,
              height: MediaQuery.of(context).size.height * 0.7,
              initialPage: index1,
              indicatorColor: kNavigationButtonColor,
              indicatorBackgroundColor: kWhiteColor,
              children: _listOfImages
                  .map(
                    (e) => ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: e.contains('http')
                            ? Image.network(e)
                            : Image.asset(e)
                        // CachedNetworkImage(
                        //   imageUrl: '${dataModel.banner_image}',
                        //   placeholder: (context, url) => Align(
                        //     widthFactor: 50,
                        //     heightFactor: 50,
                        //     alignment: Alignment.center,
                        //     child: Container(
                        //       padding: const EdgeInsets.all(5.0),
                        //       width: 50,
                        //       height: 180,
                        //       child: const Center(child: CircularProgressIndicator()),
                        //     ),
                        //   ),
                        //   errorWidget: (context, url, error) => Image.asset(
                        //     'assets/icon.png',
                        //     fit: BoxFit.fill,
                        //   ),
                        //   fit: BoxFit.fill,
                        // ),
                        ),
                  )
                  .toList(),
              onPageChanged: (value) => setState(() {
                index1 = value;
              }),
              autoPlayInterval: 3000,
              isLoop: true,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _listOfImages.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () => setState(() {
                      index1 = index;
                    }),
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2.0,
                          color: index == index1
                              ? kNavigationButtonColor
                              : Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.grey[300],
                      ),
                      child: _listOfImages[index1].contains('http')
                          ? Image.network(
                              _listOfImages[index1],
                            )
                          : Image.asset(
                              _listOfImages[index1],
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
