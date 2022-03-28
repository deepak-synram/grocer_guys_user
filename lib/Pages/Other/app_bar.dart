import 'package:flutter/material.dart';
import 'package:user/Routes/routes.dart';
import 'package:user/Theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title, leading;
  final widget;
  final bool centerTile;
  final function;

  const CustomAppBar({
    Key key,
    @required this.title,
    this.widget,
    this.centerTile = true,
    this.function,
    this.leading = 'assets/back-arrow-icon.png',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
      ),
      backgroundColor: kMainColor,
      centerTitle: centerTile,
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: function ?? () => Navigator.of(context).pop(),
          child: Image.asset(
            leading,
            width: 15,
            height: 15,
          ),
        ),
      ),
      title: title.isEmpty ? const SizedBox.shrink() : Text(title),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: widget ??
              InkWell(
                highlightColor: kTransparentColor,
                splashColor: kTransparentColor,
                onTap: () =>
                    Navigator.pushNamed(context, PageRoutes.notification),
                child: Image.asset(
                  'assets/bell-icon.png',
                  width: 50,
                  height: 50,
                ),
              ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
