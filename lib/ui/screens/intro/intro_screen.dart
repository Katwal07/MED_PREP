import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constants.dart';
import '../login/login_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(IS_FIRST_TIME_USER, true);
    await Get.offAll(() => LoginScreen());
  }

  Widget _buildImage(String assetName) {
    return Container(
      margin: EdgeInsets.only(top: 150.0, bottom: 0, left: 20.0, right: 20.0),
      child: Image.asset(
        'assets/images/$assetName.png',
        fit: BoxFit.contain,
        height: 250.0,
        width: 250.0,
      ),
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 14.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      titlePadding: EdgeInsets.only(top: 0),
      bodyPadding: EdgeInsets.fromLTRB(20.0, 20.0, 16.0, 16.0),
      pageColor: Colors.white,
    );

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30.0),
            child: IntroductionScreen(
                key: introKey,
                pages: [
                  PageViewModel(
                    title: "Many Questions",
                    body: "Over 40000+ MCQs with different practice modes.",
                    image: _buildImage('intro1'),
                    decoration: pageDecoration,
                  ),
                  PageViewModel(
                    title: "Full Explanation",
                    body: "Questions with Explanation & Session Performance.",
                    image: _buildImage('intro2'),
                    decoration: pageDecoration,
                  ),
                  PageViewModel(
                    title: "Everything you need.",
                    body: "Everything you need to take on Medical Entrance.",
                    image: _buildImage('intro3'),
                    decoration: pageDecoration,
                  ),
                ],
                onDone: () => _onIntroEnd(context),
                //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
                showSkipButton: false,
                skipOrBackFlex: 0,
                nextFlex: 0,
                // dotsFlex: 1,

                dotsDecorator: DotsDecorator(
                  size: Size(6.0, 6.0),
                  color: Color(0xFFF09F9F),
                  activeSize: Size(8.0, 8.0),
                  activeColor: Theme.of(context).colorScheme.secondary,
                  spacing: EdgeInsets.only(right: 10.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                ),
                skip: Container(
                  margin: EdgeInsets.only(left: 0.0),
                  child: AutoSizeText(
                    'Skip',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                next: Container(
                  // margin: EdgeInsets.only(left: 90.0),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

                  alignment: Alignment.bottomRight,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    children: [
                      const AutoSizeText(
                        'NEXT',
                        style: TextStyle(color: Colors.white),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ],
                  ),
                ),
                done: Container(
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Row(
                    children: [
                      const AutoSizeText(
                        'NEXT',
                        style: TextStyle(color: Colors.white),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    ],
                  ),
                )
                // done: const AutoSizeText('Done', style: TextStyle(fontWeight: FontWeight.w600)),
                ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.0),
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logo_transparent_1.png',
                height: 80.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
