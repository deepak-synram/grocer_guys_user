import 'package:flutter/material.dart';
import 'package:user/Theme/colors.dart';

class AccountCard extends StatelessWidget {
  final String image, title, price;
  final dynamic onClick;
  const AccountCard({
    Key key,
    @required this.image,
    @required this.title,
    this.onClick,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: kTransparentColor,
      splashColor: kTransparentColor,
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          image,
                          height: 25,
                          width: 25,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          title,
                          style: TextStyle(
                            color: kMainColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    if (price != null) ...[
                      Text(
                        price,
                        style: TextStyle(
                          color: kNavigationButtonColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ]
                  ],
                )

                // RichText(
                //   text: TextSpan(
                //     children: [
                //       WidgetSpan(
                //         child: Image.asset(
                //           image,
                //           height: 25,
                //           width: 25,
                //         ),
                //       ),
                //       TextSpan(
                //         text: title,
                //         style: TextStyle(
                //           color: kMainColor,
                //           fontWeight: FontWeight.w500,
                //           fontSize: 16,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                ),
            const Divider(thickness: 2),
          ],
        ),
      ),
    );
  }
}
