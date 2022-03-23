import 'package:flutter/material.dart';
import 'package:user/Locale/locales.dart';
import 'package:user/Pages/HomePage/product_details.dart';
import 'package:user/Theme/colors.dart';
import 'package:user/providergrocery/categoryprovider.dart';
import 'package:user/providergrocery/locemittermodel.dart';

class ProductCard extends StatefulWidget {
  final int index;
  final String image, title, previousPrice, newPrice, symbol;
  final dynamic subTitle;

  final LocEmitterModel locModel;
  final CategoryProvider catP;
  final AppLocalizations locale;

  const ProductCard({
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
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  List<bool> _isLiked = [false, false];

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
            locModel: widget.locModel,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(15.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2.25,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Image.asset(
                        widget.image,
                        width: 150,
                        height: 160,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Chip(
                            backgroundColor: Colors.green,
                            label: Text(
                              '50% OFF',
                              style: TextStyle(
                                fontSize: 8,
                                color: kWhiteColor,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isLiked[widget.index] = !_isLiked[widget.index];
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
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: kMainTextColor,
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
                  )
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
                const SizedBox(height: 5),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
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
                            borderRadius: BorderRadius.circular(15.0))),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                ),
                Row(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
