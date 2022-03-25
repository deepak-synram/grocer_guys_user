import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title, bottomImage, icon;
  final Color color;
  final double bottomImgHeight;
  final double iconSize;
  final double fontSize;
  final double height;

  const CategoryCard({
    Key key,
    @required this.title,
    @required this.bottomImage,
    @required this.color,
    @required this.icon,
    this.bottomImgHeight,
    this.height,
    this.iconSize,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15.0),
      elevation: 10,
      child: height == null
          ? SizedBox(
              width: 120,
              child: _cardWidget(
                  bottomImage: bottomImage,
                  title: title,
                  fontSize: fontSize,
                  color: color,
                  icon: icon,
                  iconSize: iconSize),
            )
          : SizedBox(
              width: 120,
              height: height,
              child: _cardWidget(
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

class _cardWidget extends StatelessWidget {
  const _cardWidget({
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
                bottomRight: Radius.circular(15.0)),
            child: Image.asset(
              bottomImage,
              fit: BoxFit.fitWidth,
              height: MediaQuery.of(context).size.height * 0.5,
              alignment: Alignment.bottomLeft,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: fontSize,
                    color: color,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Image.asset(
                icon,
                width: iconSize,
                height: iconSize,
              )
            ],
          ),
        ),
      ],
    );
  }
}
