import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user/Pages/Other/app_bar.dart';
import 'package:user/Pages/Subscription/subscription_card.dart';
import 'package:user/Pages/Subscription/subscription_data_model.dart';

import 'heading_with_data.dart';

class PauseSubscriptionPage extends StatefulWidget {
  final SubscriptionDataModel sdm;

  const PauseSubscriptionPage({
    Key key,
    @required this.sdm,
  }) : super(key: key);

  @override
  _PauseSubscriptionPageState createState() => _PauseSubscriptionPageState();
}

class _PauseSubscriptionPageState extends State<PauseSubscriptionPage> {
  String startDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String endDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  Color darkBlueShade = const Color(0xff022e2b);
  Color yellowishShade = const Color(0xffffc339);

  DateTime _startDate;

  //Method for showing the date picker
  void _pickDateDialog(bool isStartDate) {
    showDatePicker(
            context: context,
            initialDate: isStartDate ? DateTime.now() : _startDate,
            //which date will display when user open the picker
            firstDate: isStartDate ? DateTime.now() : _startDate,
            //what will be the previous supported year in picker
            lastDate: DateTime(
                2023)) //what will be the up to supported date in picker
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        if (isStartDate) {
          startDate = DateFormat('yyyy-MM-dd').format(pickedDate);
          _startDate = pickedDate;
        } else {
          endDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Pause Subscription'),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SubscriptionCard(
            sdm: widget.sdm,
            isMiniCard: false,
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Select Dates',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: darkBlueShade),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _pickDateDialog(true);
                    },
                    child: HeadingWithData(
                      noHeightData: false,
                      heading: 'Start Date',
                      // data: Container(),
                      data: Card(
                        child: ListTile(
                          // contentPadding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          leading: Text(startDate),
                          trailing: Image.asset(
                            'assets/Subscribe/ic_calender.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _pickDateDialog(false);
                    },
                    child: HeadingWithData(
                      noHeightData: false,
                      heading: 'End Date',
                      // data: Container(),
                      data: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Card(
                          child: ListTile(
                            leading: Text(endDate),
                            trailing: Image.asset(
                              'assets/Subscribe/ic_calender.png',
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
              child: SizedBox(
            height: 100,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: darkBlueShade,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    HeadingWithData(
                      noHeightData: true,
                      headingColor: Colors.white38,
                      heading: 'Subscription Resumes on',
                      data: Text(
                        endDate,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        print('Want to pause !!!! ');
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: yellowishShade,
                        ),
                        child: const Center(
                          child: Text(
                            'Pause Subscription',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
