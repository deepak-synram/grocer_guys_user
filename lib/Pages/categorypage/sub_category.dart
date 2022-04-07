import 'package:flutter/material.dart';
import 'package:user/Pages/HomePage/category_card.dart';
import 'package:user/Pages/Other/app_bar.dart';
import 'package:user/Pages/categorypage/sub_category_page_details.dart';
import 'package:user/beanmodel/cart/cartitembean.dart';
import 'package:user/beanmodel/singleapibean.dart';
import 'package:user/providergrocery/locemittermodel.dart';

class ViewAllSubCategory extends StatefulWidget {
  const ViewAllSubCategory({Key key, this.locModel, this.cartItemd, this.cat})
      : super(key: key);
  final LocEmitterModel locModel;
  final List<CartItemData> cartItemd;
  final TopCat cat;

  @override
  _ViewAllSubCategoryState createState() => _ViewAllSubCategoryState();
}

class _ViewAllSubCategoryState extends State<ViewAllSubCategory> {
  List<String> staticIcon = [
    'assets/CategoryImages/snacks-branded-food.png',
    'assets/CategoryImages/food-grain-oil-masala.png',
    'assets/CategoryImages/bakery-cake-dairy.png',
    'assets/CategoryImages/fruits-vegitables.png',
    'assets/CategoryImages/fruits-vegitables.png',
    'assets/CategoryImages/bakery-cake-dairy.png',
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
    const Color.fromRGBO(79, 130, 50, 1.0),
    const Color.fromRGBO(143, 41, 52, 1.0),
    const Color.fromRGBO(101, 178, 169, 1.0),
    const Color.fromRGBO(185, 78, 117, 1.0),
    const Color.fromRGBO(101, 178, 169, 1.0),
    const Color.fromRGBO(185, 78, 117, 1.0),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Sub Category',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: getGrid(widget.cat),
      ),
    );
  }

  Widget getGrid(TopCat cats) {
    return GridView.builder(
      itemCount: cats.subcategory.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.8,
        crossAxisCount: 2,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
      ),
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SubCategoryPageDetails(
                  cartItemd: widget.cartItemd,
                  locModel: widget.locModel,
                  catId: cats.subcategory[index].catId.toString(),
                  storeId: cats.subcategory[index].storeId.toString(),
                  appBarImage: staticImage[index],
                ),
              ),
            ),
            child: CategoryCard(
                title: cats.subcategory[index].title,
                // Color(0xff+apiData.dataModel.topCat[index].iconColor) ??
                color: staticColor[index],
                bottomImage:
                    // '$imagebaseUrl1 + ${apiData.dataModel.topCat[index].image.substring(1)}',
                    staticImage[index],
                icon: cats.subcategory[index].otherImages ?? staticIcon[index],
                // bottomImgHeight: 60,
                iconSize: 85,
                fontSize: 16),
          ),
        );
      },
    );
  }
}
