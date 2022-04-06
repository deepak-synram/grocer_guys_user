import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timelines/timelines.dart';
import 'package:user/Auth/Login/sign_in.dart';
import 'package:user/Pages/Intro/splash.dart';
import 'package:user/Routes/routes.dart';
import 'package:user/Theme/colors.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('intro_checked', true);
    Navigator.of(context).pushNamedAndRemoveUntil(
        PageRoutes.signInRoot, (Route<dynamic> route) => false);
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/IntroScreen/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
        titleTextStyle: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w700),
        bodyTextStyle: bodyStyle,
        titlePadding: EdgeInsets.only(top: 40.0),
        bodyPadding: EdgeInsets.fromLTRB(20.0, 24.0, 16.0, 16.0),
        // pageColor: kTextColor,
        imagePadding: EdgeInsets.only(top: 40.0),
        imageFlex: 2);

    return Container(
      // width: double.infinity,
      // height: 200,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/IntroScreen/intro_screen.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.transparent,
        globalHeader: Align(
          alignment: Alignment.topRight,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kMainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Skip',
                      style: TextStyle(color: kTextColor),
                    ),
                    const SizedBox(width: 5),
                    Icon(Icons.arrow_forward_ios, color: kTextColor, size: 15)
                  ],
                ),
                onPressed: () => _onIntroEnd(context),
              ),
            ),
          ),
        ),
        pages: [
          PageViewModel(
            title: "Welcome to the Grocery Guys!\nYour Grocery Application",
            body:
                "Instead of having to buy an entire share, invest any amount you want.",
            image: _buildImage('logo-1.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "We Provide Best Quality Product To You Family",
            body:
                "Download the Stockpile app and master the market with our mini-lesson.",
            image: _buildImage('logo-2.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Fast And Responsibility delivery By 2 Hours only",
            body:
                "Kids and teens can track their stocks 24/7 and place trades that you approve.",
            image: _buildImage('logo-3.png'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        showSkipButton: false,
        skipOrBackFlex: 0,
        nextFlex: 7,
        dotsFlex: 0,
        showBackButton: false,
        showNextButton: true,
        skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
        next: Align(
          alignment: Alignment.bottomRight,
          child: _buildImage('back.png', 60),
        ),
        done: Align(
          alignment: Alignment.bottomRight,
          child: _buildImage('back.png', 60),
          
        ),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(4),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 0.0),
        dotsDecorator: DotsDecorator(
          size: const Size(10.0, 10.0),
          color: kMainColor,
          activeSize: const Size(22.0, 10.0),
          activeShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          activeColor: kNavigationButtonColor,
        ),
      ),
    );

  }
}
