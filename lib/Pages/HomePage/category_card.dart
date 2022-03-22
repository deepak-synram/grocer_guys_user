import 'package:flutter/material.dart';
import 'package:user/Theme/colors.dart';

class CategoryCard extends StatelessWidget {
  final String title, bottomImage, icon;
  final Color color;

  const CategoryCard({
    Key key,
    @required this.title,
    @required this.bottomImage,
    @required this.color,
    @required this.icon,
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
            Positioned.fill(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0)),
                child: Image.asset(
                  bottomImage,
                  // ,
                  fit: BoxFit.fitWidth,
                  height: 60,
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
                    style:
                        TextStyle(color: color, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Image.asset(
                    icon,
                    width: 65,
                    height: 65,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
