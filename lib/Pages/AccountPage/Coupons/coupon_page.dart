import 'package:flutter/material.dart';
import 'package:user/Pages/Other/app_bar.dart';

import 'coupon_card.dart';

class CouponPage extends StatefulWidget {
  const CouponPage({Key key}) : super(key: key);

  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Coupons'),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemBuilder: (context, index) {
            return const CouponCard(
              desc: '',
              imgName: 'assets/ProductImages/tomato.png',
              offPercent: '10',
              code: 'TOMRED10',
              validity: '30 Days',
            );
          },
          itemCount: 4,
        ),
      ),
    );
  }
}
