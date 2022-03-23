import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:user/Locale/locales.dart';
import 'package:user/Pages/HomePage/full_screen_image.dart';
import 'package:user/Pages/HomePage/full_screen_image_modal.dart';
import 'package:user/Pages/HomePage/product_card_with_title.dart';
import 'package:user/Pages/Other/app_bar.dart';
import 'package:user/Theme/colors.dart';
import 'package:user/providergrocery/categoryprovider.dart';
import 'package:user/providergrocery/locemittermodel.dart';

class ProductDetails extends StatefulWidget {
  final int index;
  final String image, title, previousPrice, newPrice, symbol;
  final dynamic subTitle;
  final LocEmitterModel locModel;
  final CategoryProvider catP;
  final AppLocalizations locale;
  final bool isLiked;

  const ProductDetails({
    Key key,
    @required this.locModel,
    @required this.catP,
    @required this.locale,
    @required this.index,
    @required this.title,
    @required this.image,
    @required this.subTitle,
    @required this.previousPrice,
    @required this.newPrice,
    @required this.symbol,
    @required this.isLiked,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool _isLiked = false;

  @override
  void initState() {
    setState(() {
      _isLiked = widget.isLiked;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Product Details'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Card(
                elevation: 3,
                shadowColor: kWhiteColor.withOpacity(0.7),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Image.asset(
                            widget.image,
                            width: MediaQuery.of(context).size.width / 3,
                            height: 200,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Chip(
                                backgroundColor: Colors.green,
                                label: Text(
                                  '50% OFF',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: kWhiteColor,
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _isLiked = !_isLiked;
                                      });
                                    },
                                    icon: Icon(
                                      _isLiked
                                          ? Icons.favorite_outlined
                                          : Icons.favorite_outline,
                                      color: _isLiked
                                          ? kNavigationButtonColor
                                          : kMainColor,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  InkWell(
                                      splashColor: kTransparentColor,
                                      highlightColor: kTransparentColor,
                                      onTap: () => Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  FullScreenView(
                                                image: widget.image,
                                                locale: widget.locale,
                                              ),
                                            ),
                                          ),
                                      child: const Icon(Icons.fullscreen)),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.subTitle,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            widget.symbol + widget.newPrice,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: kMainTextColor,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(width: 5),
                          if (widget.previousPrice != null) ...[
                            Text(
                              widget.symbol + widget.previousPrice,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600],
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ]
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            '3.0',
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(width: 5),
                          RatingBar.builder(
                            initialRating: 3.5,
                            minRating: 0,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            unratedColor: Colors.amber.withAlpha(50),
                            itemCount: 5,
                            itemSize: 20.0,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                            updateOnDrag: false,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '(98 reviews)',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          color: Colors.grey[300],
                        ),
                        height: 52,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Quantity',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.remove_circle),
                                  ),
                                  Text('1'),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add_circle),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          color: Colors.grey[300],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              const Text(
                                'Product Details',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 42.0,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: kMainColor,
                            ),
                            onPressed: () {},
                            child: Text(
                              'ADD TO CART',
                              style: TextStyle(
                                color: kWhiteColor,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ProductsCardWithTitle(
                title: 'Related Products',
                catP: widget.catP,
                locale: widget.locale,
                locModel: widget.locModel,
              )
            ],
          ),
        ),
      ),
    );
  }
}
