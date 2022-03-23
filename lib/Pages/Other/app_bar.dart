import 'package:flutter/material.dart';
import 'package:user/Theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final widget;

  const CustomAppBar({
    Key key,
    @required this.title,
    this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kMainColor,
      centerTitle: true,
      leading: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          width: 15,
          height: 15,
          padding: const EdgeInsets.all(1.0),
          decoration: BoxDecoration(
            color: kNavigationButtonColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          // margin: const EdgeInsets.all(5),
          child: Center(
            child: Icon(
              Icons.arrow_back_ios,
              color: kMainColor,
            ),
          ),
        ),
        // Image.asset(
        //   'assets/bell-icon.png',
        //   width: 15,
        //   height: 15,
        // ),
      ),
      title: title.isEmpty ? const SizedBox.shrink() : Text(title),
      actions: [
        widget ??
            Image.asset(
              'assets/bell-icon.png',
              width: 50,
              height: 50,
            )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(48.0);
}
