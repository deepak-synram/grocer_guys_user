import 'package:flutter/material.dart';

import 'coupon_lower_card_custom_clipper.dart';
import 'coupon_upper_card_custom_clipper.dart';

class CouponCard extends StatefulWidget {
  final String imgName;
  final String offPercent;
  final String code;
  final String desc;
  final String validity;

  const CouponCard(
      {Key key,
      this.imgName,
      this.offPercent,
      this.code,
      this.desc,
      this.validity})
      : super(key: key);

  @override
  _CouponCardState createState() => _CouponCardState();
}

class _CouponCardState extends State<CouponCard> {
  Color greenShade = const Color(0xff022e2b);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          Flexible(
            flex: 8,
            child: ClipPath(
              clipper: CouponUpperCardCustomClipper(holeRadius: 12),
              child: Card(
                color: Colors.grey[300],
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        widget.imgName,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      '${widget.offPercent}% OFF',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: greenShade),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'CODE: ${widget.code}',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, color: greenShade),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    if (widget.desc.isNotEmpty)
                      Text(
                        widget.desc,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[800],
                        ),
                      ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Valid for ${widget.validity}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey[800],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: ClipPath(
              clipper: CouponLowerCardCustomClipper(holeRadius: 12),
              child: Container(
                margin: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                decoration: BoxDecoration(color: greenShade),
                child: Center(
                  child: TextButton(
                    child: const Text(
                      'REDEEM',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      // WIll redeem here
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
