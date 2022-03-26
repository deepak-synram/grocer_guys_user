import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:user/Components/drawer.dart';
import 'package:user/Locale/locales.dart';
import 'package:user/Pages/Other/app_bar.dart';
import 'package:user/Routes/routes.dart';
import 'package:user/Theme/colors.dart';
import 'package:user/baseurl/baseurlg.dart';
import 'package:user/beanmodel/aboutus.dart';
import 'package:user/main.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  var userName;
  bool islogin = false;
  dynamic title;
  dynamic content;

  @override
  void initState() {
    super.initState();
    getWislist();
  }

  void getWislist() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userName = pref.getString('user_name');
      islogin = pref.getBool('islogin');
    });
    var url = appAboutusUri;
    var http = Client();
    http.get(url, headers: {
      'Authorization': 'Bearer ${pref.getString('accesstoken')}'
    }).then((value) {
      print('resp - ${value.body}');
      if (value.statusCode == 200) {
        AboutUsMain data1 = AboutUsMain.fromJsom(jsonDecode(value.body));
        print(data1.toString());
        if (data1.status == "1" || data1.status == 1) {
          setState(() {
            title = data1.data.title;
            content = data1.data.description;
          });
        }
      }
    }).catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return Scaffold(
      appBar: CustomAppBar(title: locale.aboutUs),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Image.asset(
                  'assets/logo.png',
                  scale: 2.5,
                  height: 150,
                ),
                const SizedBox(
                  height: 10,
                ),
                (content != null)
                    ? Html(
                        data: content,
                        style: {
                          "html": Style(
                            fontSize: FontSize.large,
                          ),
                        },
                      )
                    : Container(),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Divider(thickness: 2),
                ListTile(
                  tileColor: Colors.grey[200],
                  title: Align(
                    alignment: const Alignment(-1.4, 0.0),
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        color: kMainColor,
                      ),
                    ),
                  ),
                  leading: Icon(
                    Icons.policy,
                    color: kMainColor,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: kMainColor,
                    size: 20,
                  ),
                ),
                const Divider(thickness: 2),
                ListTile(
                  tileColor: Colors.grey[200],
                  title: Align(
                    alignment: const Alignment(-1.4, 0.0),
                    child: Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        color: kMainColor,
                      ),
                    ),
                  ),
                  leading: Icon(
                    Icons.text_snippet_sharp,
                    color: kMainColor,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: kMainColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
