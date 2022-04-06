import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:user/Locale/locales.dart';
import 'package:user/Pages/HomePage/product_details.dart';
import 'package:user/Pages/Subscription/subscribe.dart';
import 'package:user/Theme/colors.dart';
import 'package:user/providergrocery/categoryprovider.dart';
import 'package:user/providergrocery/locemittermodel.dart';

class ProductCard extends StatefulWidget {
  final int index, total;
  final String image, title, previousPrice, newPrice, symbol;
  final dynamic subTitle;
  final bool isSubscribe;

  final LocEmitterModel locModel;
  final CategoryProvider catP;
  final AppLocalizations locale;
  // final double width, height;

  const ProductCard({
    Key key,
    @required this.total,
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
    // this.width = 150,
    // this.height = 160,
    this.isSubscribe,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  List<bool> _isLiked = [];

  @override
  void initState() {
    super.initState();
    _getIsLikedArray();
  }

  _getIsLikedArray() {
    List<bool> _temp = [];
    for (int i = 0; i < widget.total; i++) {
      _temp.add(false);
    }
    setState(() {
      _isLiked = _temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: kTransparentColor,
      splashColor: kTransparentColor,
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetails(
            index: widget.index,
            title: widget.title,
            image: widget.image,
            subTitle: widget.subTitle,
            previousPrice: widget.previousPrice,
            newPrice: widget.newPrice,
            symbol: widget.symbol,
            isLiked: _isLiked[widget.index],
            catP: widget.catP,
            locale: widget.locale,
            productId: 50,
            locModel: widget.locModel,
          ),
        ),
      ),
      child: Padding(
        key: Key('product-card-${widget.index.toString()}'),
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2.25,
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: CachedNetworkImage(
                        width: 100,
                        height: 100,
                        imageUrl: widget.image,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/HomeBanner/no-icon.png'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            padding:
                                const EdgeInsets.only(top: 1.0, bottom: 1.0),
                            backgroundColor: Colors.green,
                            label: Text(
                              '50% OFF',
                              style: TextStyle(
                                fontSize: 8,
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _isLiked[widget.index] =
                                    !_isLiked[widget.index];
                              });
                            },
                            icon: Icon(
                              _isLiked[widget.index]
                                  ? Icons.favorite_outlined
                                  : Icons.favorite_outline,
                              color: _isLiked[widget.index]
                                  ? kNavigationButtonColor
                                  : kMainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: kMainTextColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                if (widget.subTitle is String) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      widget.subTitle,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ],
                if (widget.subTitle is List) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: DropdownButtonFormField(items: widget.subTitle),
                  )
                ],
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      if (widget.previousPrice != null) ...[
                        Row(
                          children: [
                            Text(
                              widget.symbol + widget.previousPrice,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[600],
                                  decoration: TextDecoration.lineThrough),
                            ),
                            const SizedBox(width: 5),
                          ],
                        ),
                        Text(
                          widget.symbol + widget.newPrice,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: kMainTextColor,
                            fontSize: 20,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                if (widget.isSubscribe != null && widget.isSubscribe) ...[
                  const SizedBox(height: 5),
                  Center(
                    child: SizedBox(
                      height: 30.0,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Subscribe(
                              image: widget.image,
                              price: widget.symbol + widget.newPrice,
                              title: widget.title,
                              id: widget.index.toString(),
                              subTitle: widget.subTitle,
                            ),
                          ),
                        ),
                        child: Text(
                          'SUBSCRIBE @ ${widget.symbol + widget.newPrice}',
                          style: TextStyle(
                            fontSize: 12,
                            color: kMainColor,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: kNavigationButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 5),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/CategoryImages/add-to-bag-icon.png',
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(width: 5),
                    Text('Add To Bag', style: TextStyle(color: kMainTextColor)),
                  ],
                ),
                // const SizedBox(
                //   height: 5,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
