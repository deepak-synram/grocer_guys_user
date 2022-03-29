import 'package:flutter/material.dart';

class CouponUpperCardCustomClipper extends CustomClipper<Path> {
  CouponUpperCardCustomClipper({@required this.holeRadius});

  final double holeRadius;

  @override
  Path getClip(Size size) {
    double radius = holeRadius;

    Path path = Path()
      ..moveTo(radius, 0)
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(Offset(size.width, radius), radius: Radius.circular(radius))
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(Offset(size.width - radius, size.height),
          radius: Radius.circular(radius), clockwise: false)
      ..lineTo(radius, size.height)
      ..arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius), clockwise: false)
      ..lineTo(0, radius)
      ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CouponUpperCardCustomClipper oldClipper) => true;
}
