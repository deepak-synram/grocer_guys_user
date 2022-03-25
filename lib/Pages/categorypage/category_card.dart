import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title, bottomImage, icon;
  final Color color;
  final double bottomImgHeight;
  final double iconSize;
  final double fontSize;

  const CategoryCard({
    Key key,
    @required this.title,
    @required this.bottomImage,
    @required this.color,
    @required this.icon,
    this.bottomImgHeight,
    this.iconSize,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(15.0),
      elevation: 10,
      child: SizedBox(
        width: 120,
        child: Stack(
          children: [
            Expanded(
              child: Center(
                child: Positioned.fill(
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
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
