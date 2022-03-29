import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:user/Pages/Other/app_bar.dart';

class ReferAndEarn extends StatefulWidget {
  const ReferAndEarn({Key key}) : super(key: key);

  @override
  _ReferAndEarnState createState() => _ReferAndEarnState();
}

class _ReferAndEarnState extends State<ReferAndEarn> {
  Color darkBlueShade = const Color(0xff022e2b);
  Color yellowishShade = const Color(0xffffc339);
  String referCode = "VHUJD21K";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Invite & Earn'),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            const Expanded(
              child: SizedBox(
                height: 100,
              ),
            ),
            const Text('Refer & Earn Wallet Amount Upto',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('from 1 to 15',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: referCode));
              },
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        referCode,
                        style: TextStyle(
                            color: yellowishShade,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text('Tap to copy')
                    ],
                  ),
                ),
              ),
            ),
            const Expanded(
                child: SizedBox(
              height: 100,
            )),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(darkBlueShade),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
              onPressed: () {
                print('Inviting People');
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Center(
                  child: Text(
                    'Invite Friends',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
