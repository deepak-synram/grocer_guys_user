import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:user/Theme/colors.dart';

class NewCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final widget;
  final String backgroundImage;

  const NewCustomAppBar({
    Key key,
    @required this.title,
    this.widget,
    this.backgroundImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   alignment: AlignmentDirectional.center,
    //   decoration: backgroundImage != null
    //       ? BoxDecoration(
    //           image: DecorationImage(
    //               image: Image.asset(backgroundImage).image, fit: BoxFit.cover))
    //       : const BoxDecoration(),
    //   child:
    return AppBar(
      backgroundColor:
          backgroundImage == null ? kMainColor : Colors.transparent,
      flexibleSpace: backgroundImage != null
          ? Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                image: DecorationImage(
                  colorFilter:
                      ColorFilter.mode(kTransparentColor, BlendMode.saturation),
                  image: AssetImage(backgroundImage),
                  fit: BoxFit.cover,
                ),
              ),
            )
          : Container(),
      centerTitle: true,
      leading: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Image.asset(
          'assets/back-arrow-icon.png',
          width: 15,
          height: 15,
        ),
      ),
      title: title.isEmpty
          ? const SizedBox.shrink()
          : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              widget ??
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.3, 2, 2, 2),
                    child: Image.asset(
                      'assets/bell-icon.png',
                      width: 50,
                      height: 50,
                    ),
                  )
            ]),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(220.0);
}
