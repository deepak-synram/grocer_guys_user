import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title, bottomImage, icon;
  final Color color;
  final double bottomImgHeight;
  final double iconSize;
  final double fontSize;
  final double width;

  const CategoryCard({
    Key key,
    @required this.title,
    @required this.bottomImage,
    @required this.color,
    @required this.icon,
    this.bottomImgHeight,
    this.width = 120,
    this.iconSize,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15.0),
      elevation: 10,
      child: SizedBox(
        width: width,
        child: CardWidget(
            bottomImage: bottomImage,
            title: title,
            fontSize: fontSize,
            color: color,
            icon: icon,
            iconSize: iconSize),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key key,
    @required this.bottomImage,
    @required this.title,
    @required this.fontSize,
    @required this.color,
    @required this.icon,
    @required this.iconSize,
  }) : super(key: key);

  final String bottomImage;
  final String title;
  final double fontSize;
  final Color color;
  final String icon;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 60),
              child: bottomImage.contains('http')
                  ? Image.network(
                      bottomImage,
                      fit: BoxFit.fitWidth,
                      height: MediaQuery.of(context).size.height * 0.5,
                      alignment: Alignment.bottomLeft,
                    )
                  : Image.asset(
                      bottomImage,
                      fit: BoxFit.fitWidth,
                      height: MediaQuery.of(context).size.height * 0.5,
                      alignment: Alignment.bottomLeft,
                    ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: fontSize > 15 ? 40 : 30,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: fontSize,
                      color: color,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 5),
              // CachedNetworkImage(
              //   imageUrl: icon,
              //   width: iconSize,
              //   height: iconSize,
              //   placeholder: (context, url) => Center(
              //     child: Container(
              //       padding: const EdgeInsets.all(5.0),
              //       width: 50,
              //       height: 180,
              //       child: const Center(child: CircularProgressIndicator()),
              //     ),
              //   ),
              //   errorWidget: (context, url, error) => Center(
              //     child: Image.asset(
              //       'assets/HomeBanner/no-icon.png',
              //       fit: BoxFit.fill,
              //     ),
              //   ),
              //   fit: BoxFit.fill,
              // ),
              if (icon.contains('http'))
                Center(
                  child: Image.network(
                    icon,
                    width: iconSize,
                    height: iconSize,
                  ),
                )
              else
                Center(
                  child: Image.asset(
                    icon,
                    width: iconSize,
                    height: iconSize,
                  ),
                )
            ],
          ),
        ),
      ],
    );
  }
}
