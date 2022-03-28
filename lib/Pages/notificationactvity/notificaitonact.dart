import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:user/Components/drawer.dart';
import 'package:user/Locale/locales.dart';
import 'package:user/Pages/Other/app_bar.dart';
import 'package:user/Routes/routes.dart';
import 'package:user/Theme/colors.dart';
import 'package:user/baseurl/baseurlg.dart';
import 'package:user/beanmodel/notificationbean/notificationlistdata.dart';
import 'package:user/main.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationShow extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NotificationShowState();
  }
}

class NotificationShowState extends State<NotificationShow> {
  var http = Client();
  List<NotificationListData> listdata = [];
  bool isLoading = false;
  String userName;
  bool islogin = false;

  @override
  void initState() {
    super.initState();
    getProfileValue();
  }

  void getProfileValue() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    dynamic userId = preferences.getInt('user_id');
    setState(() {
      islogin = preferences.getBool('islogin');
      userName = preferences.getString('user_name');
    });
    getNotificaitonList(userId, preferences);
  }

  void getNotificaitonList(dynamic userid, SharedPreferences pref) async {
    setState(() {
      isLoading = true;
    });
    http.post(notificationListUri, body: {
      'user_id': '$userid'
    }, headers: {
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    }).then((value) {
      if (value.statusCode == 200) {
        NotificationList data1 =
            NotificationList.fromJson(jsonDecode(value.body));
        if ('${data1.status}' == '1') {
          setState(() {
            listdata.clear();
            listdata = List.from(data1.data);
          });
        }
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((e) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: const Color(0xfff8f8f8),
      appBar: CustomAppBar(
        title: locale.notificaitonh,
        widget: const SizedBox.shrink(),
      ),
      body: (!isLoading && listdata != null && listdata.isNotEmpty)
          ? SingleChildScrollView(
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: listdata.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    bool isImagePresent = '${listdata[index].image}' != null &&
                        '${listdata[index].image}' != 'N/A' &&
                        '${listdata[index].image}'.toUpperCase() != 'NULL';
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: Material(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 5.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              title: Transform.translate(
                                offset: Offset(isImagePresent ? -16 : 5, 0),
                                child: Text(
                                  '${listdata[index].notiTitle}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: kMainColor,
                                  ),
                                ),
                              ),
                              subtitle: Transform.translate(
                                offset: Offset(isImagePresent ? -16 : 5, 0),
                                child: Text(
                                  '${listdata[index].notiMessage}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: kMainTextColor,
                                  ),
                                ),
                              ),
                              leading: isImagePresent
                                  ? Container(
                                      height: 80,
                                      width: 80,
                                      margin: const EdgeInsets.only(bottom: 5),
                                      // width: MediaQuery.of(context).size.width,
                                      child: Image.network(
                                          '${listdata[index].image}'),
                                    )
                                  : null),
                        ),
                      ),
                    );
                  }),
            )
          : Align(
              child: isLoading
                  ? const SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    )
                  : Text(locale.nonotificaiton),
            ),
    );
  }
}
