import 'package:flutter/material.dart';

class HeadingWithData extends StatefulWidget {
  final Widget data;
  final String heading;
  Color headingColor = Colors.black;
  final bool noHeightData;

  HeadingWithData(
      {Key key, this.data, this.heading, this.headingColor, this.noHeightData})
      : super(key: key);
  @override
  _HeadingWithDataState createState() => _HeadingWithDataState();
}

class _HeadingWithDataState extends State<HeadingWithData> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.heading,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: widget.headingColor),
        ),
        const SizedBox(
          height: 3,
        ),
        widget.noHeightData
            ? widget.data
            : SizedBox(width: 200, height: 50, child: widget.data)
      ],
    );
  }
}
