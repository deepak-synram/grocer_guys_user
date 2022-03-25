import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:user/Pages/Other/app_bar.dart';
import 'package:user/Routes/routes.dart';
import 'package:user/Theme/colors.dart';

class SuccessfulSubscription extends StatefulWidget {
  final DateTime selectedDate;
  const SuccessfulSubscription({
    Key key,
    @required this.selectedDate,
  }) : super(key: key);

  @override
  State<SuccessfulSubscription> createState() => _SuccessfulSubscriptionState();
}

class _SuccessfulSubscriptionState extends State<SuccessfulSubscription> {
  double _rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Your Subscription Successful',
        leading: 'assets/ic_cross.png',
        centerTile: false,
        widget: const SizedBox.shrink(),
        function: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Material(
              borderRadius: BorderRadius.circular(15.0),
              elevation: 5,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Image.asset(
                      'assets/Subscribe/successful.png',
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Your Subscription will start from ${DateFormat.yMMMd().format(widget.selectedDate)}',
                      style: TextStyle(
                        color: kBlackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please recharge your GG wallet for',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'uninterrupted services.',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Feedback',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: kBlackColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'How was your shopping experience?',
                      style: TextStyle(
                        color: kBlackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    RatingBar.builder(
                      initialRating: _rating,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      unratedColor: Colors.grey,
                      itemCount: 5,
                      itemSize: 35.0,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star_rounded,
                        color: kMainColor,
                      ),
                      onRatingUpdate: (double rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                      updateOnDrag: true,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
