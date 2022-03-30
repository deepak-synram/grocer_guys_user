import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:user/Pages/Other/app_bar.dart';
import 'package:user/Pages/Subscription/successful_subscription.dart';
import 'package:user/Theme/colors.dart';

enum PickSchedule { daily, alternate, threeDays, weekly, monthly }

class Subscribe extends StatefulWidget {
  final String image, price, title, subTitle, id;
  const Subscribe({
    Key key,
    @required this.image,
    @required this.price,
    @required this.title,
    @required this.id,
    @required this.subTitle,
  }) : super(key: key);

  @override
  State<Subscribe> createState() => _SubscribeState();
}

class _SubscribeState extends State<Subscribe> {
  PickSchedule _pickSchedule;
  DateTime _selectedDate;
  Map<String, dynamic> _selectedAddressData = {};
  int _selectedAddress;

  Future _openCalender(pickSchedule) async {
    dynamic widget = const SizedBox.shrink();
    switch (pickSchedule) {
      case PickSchedule.alternate:
        return await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2030, 1, 1),
          helpText: _selectedDate != null
              ? _selectedDate.year.toString()
              : DateTime.now().year.toString(),
          builder: (context, child) {
            return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: kMainColor,
                  textTheme: TextTheme(
                    headline1: TextStyle(color: kNavigationButtonColor),
                  ),
                  colorScheme: ColorScheme.light(primary: kMainColor),
                  textButtonTheme: TextButtonThemeData(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          side: BorderSide(color: kMainColor),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ),
                  ),
                ),
                child: child);
          },
        ).then((value) {
          if (value == null) {
            setState(() {
              _pickSchedule = null;
            });
          } else {
            setState(() {
              _pickSchedule = pickSchedule;
              _selectedDate = value;
            });
          }
        });

        break;
      default:
    }
    log(widget.toString());
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Subscribe'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _itemInfo(),
              const SizedBox(height: 20),
              const Text(
                'Pick Scheduled',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              _pickScheduled(),
              const SizedBox(height: 20),
              const Text(
                'Apply Coupons',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              _coupon(),
              const SizedBox(height: 20),
              _addressList(),
            ],
          ),
        ),
      ),
    );
  }

  Card _itemInfo() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: (widget.image.contains('http') ||
                          widget.image.contains('https'))
                      ? Image.network(
                          widget.image,
                          height: 100,
                          width: 100,
                        )
                      : Image.asset(
                          widget.image,
                          height: 100,
                          width: 100,
                        ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.subTitle,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[400]),
                      ),
                      const SizedBox(height: 5),
                      RichText(
                        text: TextSpan(
                          text: 'Subscription Price: ',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[400]),
                          children: <TextSpan>[
                            TextSpan(
                              text: widget.price,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kBlackColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.remove_circle_outline,
                      color: kNavigationButtonColor,
                    ),
                    const SizedBox(width: 5),
                    Text('1'),
                    const SizedBox(width: 5),
                    Icon(
                      Icons.add_circle_outline,
                      color: kNavigationButtonColor,
                    )
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 100),
              child: Text(
                '*Price may change as per market changes',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _pickScheduled() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ChoiceChip(
                    backgroundColor: kWhiteColor,
                    selectedColor: kNavigationButtonColor,
                    label: Text(
                      'Daily',
                      style: TextStyle(
                        color: kMainColor,
                      ),
                    ),
                    selected: _pickSchedule == PickSchedule.daily,
                    side: BorderSide(color: kMainColor),
                    onSelected: (bool selected) {
                      setState(() {
                        _pickSchedule = PickSchedule.daily;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ChoiceChip(
                    backgroundColor: kWhiteColor,
                    selectedColor: kNavigationButtonColor,
                    label: Text(
                      'Alternate Days',
                      style: TextStyle(
                        color: kMainColor,
                      ),
                    ),
                    selected: _pickSchedule == PickSchedule.alternate,
                    side: BorderSide(color: kMainColor),
                    onSelected: (bool selected) {
                      _openCalender(PickSchedule.alternate);
                      // setState(() {
                      //   _pickSchedule = PickSchedule.alternate;
                      // });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ChoiceChip(
                    backgroundColor: kWhiteColor,
                    selectedColor: kNavigationButtonColor,
                    label: Text(
                      'Every 3 Days',
                      style: TextStyle(
                        color: kMainColor,
                      ),
                    ),
                    selected: _pickSchedule == PickSchedule.threeDays,
                    side: BorderSide(color: kMainColor),
                    onSelected: (bool selected) {
                      setState(() {
                        _pickSchedule = PickSchedule.threeDays;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ChoiceChip(
                    backgroundColor: kWhiteColor,
                    selectedColor: kNavigationButtonColor,
                    label: Text(
                      'Weekly',
                      style: TextStyle(
                        color: kMainColor,
                      ),
                    ),
                    selected: _pickSchedule == PickSchedule.weekly,
                    side: BorderSide(color: kMainColor),
                    onSelected: (bool selected) {
                      setState(() {
                        _pickSchedule = PickSchedule.weekly;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ChoiceChip(
                    backgroundColor: kWhiteColor,
                    selectedColor: kNavigationButtonColor,
                    label: Text(
                      'Monthly',
                      style: TextStyle(
                        color: kMainColor,
                      ),
                    ),
                    side: BorderSide(color: kMainColor),
                    selected: _pickSchedule == PickSchedule.monthly,
                    onSelected: (bool selected) {
                      setState(() {
                        _pickSchedule = PickSchedule.monthly;
                      });
                    },
                  ),
                ),
              ],
            ),
            if (_selectedDate != null) ...[
              ListTile(
                title: Text(
                  'Subscription Start Date',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[400],
                  ),
                ),
                subtitle: Text(
                  DateFormat.yMMMEd().format(_selectedDate).toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: kBlackColor,
                  ),
                ),
                trailing: Image.asset(
                  'assets/Subscribe/ic_edit.png',
                  height: 30,
                  width: 30,
                ),
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Service Charge:',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[400],
                    ),
                  ),
                  Text(
                    '\u{20B9}' + '0' + '*',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: kBlackColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                'NOTE: Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[400],
                ),
              )
            ]
          ],
        ),
      ),
    );
  }

  Container _coupon() {
    return Container(
      width: double.infinity,
      height: 80.0,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter Your Coupon Code',
              contentPadding: const EdgeInsets.symmetric(
                vertical: 6.0,
                horizontal: 8.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(color: kMainColor, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(color: kMainColor, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(color: kMainColor, width: 2.0),
              ),
              suffixIcon: ElevatedButton(
                child: Text(
                  'Apply',
                  style: TextStyle(color: kMainColor),
                ),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22.0,
                      vertical: 6.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(color: kMainColor, width: 2.0),
                    ),
                    primary: const Color.fromRGBO(247, 226, 176, 1.0)),
                onPressed: () {},
              ),
            ),
          ),
        ),
      ),
    );
  }

  ListView _addressList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 2,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          width: double.infinity,
          // height: 80.0,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            children: [
              Theme(
                data: ThemeData(
                  unselectedWidgetColor: kNavigationButtonColor,
                ),
                child: RadioListTile(
                  activeColor: kMainColor,
                  value: index,
                  groupValue: _selectedAddress,
                  onChanged: (value) {
                    setState(() {
                      _selectedAddress = value;
                      // _selectedAddressData[index.toString()] = value;
                    });
                  },
                  title: Text("Home"),
                  subtitle: Text(
                    "Akshay Nagar, 1st Block 1st Cross",
                    overflow: TextOverflow.ellipsis,
                  ),
                  secondary: Image.asset(
                    'assets/Subscribe/ic_edit.png',
                    height: 30,
                    width: 30,
                  ),
                  toggleable: true,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              const SizedBox(height: 10),
              if (_selectedDate != null && index == _selectedAddress) ...[
                Container(
                  decoration: BoxDecoration(
                    color: kMainColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                      right: 8.0,
                      left: 20.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Subscription Start Date',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: kWhiteColor,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              DateFormat.yMMMEd()
                                  .format(_selectedDate)
                                  .toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kWhiteColor,
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SuccessfulSubscription(
                                selectedDate: _selectedDate,
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: kNavigationButtonColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                          child: Text(
                            'Start Subscription',
                            style: TextStyle(color: kMainColor, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
