import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/Auth/Login/sign_in.dart';
import 'package:user/Auth/Login/sign_up.dart';
import 'package:user/Auth/Login/verification.dart';
import 'package:user/Pages/Intro/onboarding.dart';
import 'package:page_transition/page_transition.dart';
import 'package:user/Pages/newhomeview.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isChecked = false, _isLoggedIn = false, _isSkipped = false;

  @override
  void initState() {
    super.initState();
    _getInitialData();
  }

  _getInitialData() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool _result = _prefs.getBool('islogin') ?? false;
    bool _skip = _prefs.getBool('skip') ?? false;
    bool _checked = _prefs.getBool('intro_checked') ?? false;
    setState(() {
      _isChecked = _checked;
      _isLoggedIn = _result;
      _isSkipped = _skip;
    });
  }

  _renderNextScreen() {
    if (_isChecked) {
      ((_isSkipped != null && _isSkipped) ||
              (_isLoggedIn != null && _isLoggedIn))
          ? NewHomeView()
          : SignIn();
    } else {
      return OnboardingScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/splash_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: AnimatedSplashScreen(
        splash: 'assets/logo.png',
        nextScreen: _renderNextScreen(),
        splashTransition: SplashTransition.sizeTransition,
        pageTransitionType: PageTransitionType.topToBottom,
        splashIconSize: 500.0,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
