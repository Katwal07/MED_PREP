// ignore_for_file: prefer_const_constructors

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../../tabbar.dart';

class SorryPage extends StatefulWidget {
  const SorryPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SorryPage> createState() => _SorryPageState();
}

Color themeColor = Color.fromARGB(255, 67, 178, 209);

class _SorryPageState extends State<SorryPage> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.faceFrown,
              color: Color.fromARGB(255, 200, 39, 22),
              size: 100.0,
            ),
            SizedBox(height: screenHeight * 0.1),
            AutoSizeText(
              "Sorry!",
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.w600,
                fontSize: 36,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            AutoSizeText(
              "Payment not Successfull",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w400,
                fontSize: 17,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),
            // AutoSizeText(
            //   "You will be redirected to the home page shortly\nor click here to return to home page",
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     color: Colors.black54,
            //     fontWeight: FontWeight.w400,
            //     fontSize: 14,
            //   ),
            // ),
            // SizedBox(height: screenHeight * 0.06),
            Flexible(
                child: GestureDetector(
              onTap: () {
                Get.offAll(() => MainTabs());
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Center(
                  child: AutoSizeText(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
