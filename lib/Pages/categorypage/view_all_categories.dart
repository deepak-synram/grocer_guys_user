import 'package:flutter/material.dart';
import 'package:user/Pages/HomePage/category_card.dart';
import 'package:user/Pages/Other/app_bar.dart';
import 'package:user/Pages/categorypage/sub_category_page.dart';
import 'package:user/beanmodel/cart/cartitembean.dart';
import 'package:user/providergrocery/locemittermodel.dart';

class ViewAllCategory extends StatefulWidget {
  const ViewAllCategory({Key key, this.locModel, this.cartItemd})
      : super(key: key);
  final LocEmitterModel locModel;
  final List<CartItemData> cartItemd;

  @override
  _ViewAllCategoryState createState() => _ViewAllCategoryState();
}

class _ViewAllCategoryState extends State<ViewAllCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Category',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        // child: GridView.builder(
        child: GridView(
            // itemCount: 4,
            gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.8,
              crossAxisCount: 2,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 20.0,
            ),
            shrinkWrap: true,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return SubCategoryPage(
                        cartItemd: widget.cartItemd,
                        locModel: widget.locModel,
                      );
                    }),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CategoryCard(
                    title: 'Fruits & Vegetables',
                    color: Color.fromRGBO(79, 130, 50, 1.0),
                    bottomImage:
                        'assets/CategoryImages/fruit-vegitables-bottom.png',
                    icon: 'assets/CategoryImages/fruits-vegitables.png',
                    // bottomImgHeight: 80,
                    // height: 200,
                    iconSize: 85,
                    fontSize: 16,
                  ),
                ),
              ),
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CategoryCard(
                      title: 'Snacks & Branded Foods',
                      color: Color.fromRGBO(143, 41, 52, 1.0),
                      bottomImage:
                          'assets/CategoryImages/snacks-branded-food-bottom.png',
                      icon: 'assets/CategoryImages/snacks-branded-food.png',
                      bottomImgHeight: 80,
                      iconSize: 85,
                      fontSize: 16)),
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CategoryCard(
                      title: 'Bakery, Cake & Dairy',
                      color: Color.fromRGBO(101, 178, 169, 1.0),
                      bottomImage:
                          'assets/CategoryImages/bakery-cake-dairy-bottom.png',
                      icon: 'assets/CategoryImages/bakery-cake-dairy.png',
                      bottomImgHeight: 80,
                      iconSize: 85,
                      fontSize: 16)),
              const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CategoryCard(
                      title: 'Food, Grains, Oils & Masala',
                      color: Color.fromRGBO(185, 78, 117, 1.0),
                      bottomImage:
                          'assets/CategoryImages/food-grains-oil-masala-bottom.png',
                      icon: 'assets/CategoryImages/food-grain-oil-masala.png',
                      bottomImgHeight: 40,
                      iconSize: 85,
                      fontSize: 16)),
            ]
            // (context, index) => GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) {
            //         return SubCategoryPage(
            //           cartItemd: widget.cartItemd,
            //           locModel: widget.locModel,
            //         );
            //       }),
            //     );
            //   },
            //   child: const Padding(
            //     padding: EdgeInsets.all(8.0),
            //     child: CategoryCard(
            //       title: 'Fruits & Vegetables',
            //       color: Color.fromRGBO(79, 130, 50, 1.0),
            //       bottomImage:
            //           'assets/CategoryImages/fruit-vegitables-bottom.png',
            //       icon: 'assets/CategoryImages/fruits-vegitables.png',
            //       // bottomImgHeight: 80,
            //       height: 200,
            //       width: 80,
            //       iconSize: 85,
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
            //   const Padding(
            //       padding: EdgeInsets.all(8.0),
            //       child: CategoryCard(
            //           title: 'Snacks & Branded Foods',
            //           color: Color.fromRGBO(143, 41, 52, 1.0),
            //           bottomImage:
            //               'assets/CategoryImages/snacks-branded-food-bottom.png',
            //           icon: 'assets/CategoryImages/snacks-branded-food.png',
            //           bottomImgHeight: 80,
            //           iconSize: 85,
            //           fontSize: 16)),
            //   const Padding(
            //       padding: EdgeInsets.all(8.0),
            //       child: CategoryCard(
            //           title: 'Bakery, Cake & Dairy',
            //           color: Color.fromRGBO(101, 178, 169, 1.0),
            //           bottomImage:
            //               'assets/CategoryImages/bakery-cake-dairy-bottom.png',
            //           icon: 'assets/CategoryImages/bakery-cake-dairy.png',
            //           bottomImgHeight: 80,
            //           iconSize: 85,
            //           fontSize: 16)),
            //   const Padding(
            //       padding: EdgeInsets.all(8.0),
            //       child: CategoryCard(
            //           title: 'Food, Grains, Oils & Masala',
            //           color: Color.fromRGBO(185, 78, 117, 1.0),
            //           bottomImage:
            //               'assets/CategoryImages/food-grains-oil-masala-bottom.png',
            //           icon: 'assets/CategoryImages/food-grain-oil-masala.png',
            //           bottomImgHeight: 40,
            //           iconSize: 85,
            //           fontSize: 16)),
            // ],
            ),
      ),
    );
  }
}
