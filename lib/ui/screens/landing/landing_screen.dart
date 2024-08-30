import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../tabbar.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Theme.of(context).colorScheme.secondary,
              Color(0xFF61AEF5),
              Color(0xFF47AEF5),
              Color(0xFF28AEF5),
            ],
                stops: [
              0.1,
              0.6,
              0.7,
              0.8
            ])),
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(right: 50),
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AutoSizeText(
                'Welcome to',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0,
                ),
              ),
              SizedBox(height: 20),
              AutoSizeText(
                'MedPrep Nepal',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 50),
              Container(
                height: 120,
                width: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: 150,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: MaterialButton(
                          onPressed: () {
                            Get.off(MainTabs());
                          },
                          child: AutoSizeText(
                            'LOG IN',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: 150,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: MaterialButton(
                          onPressed: () {
                            Get.off(MainTabs());
                          },
                          child: AutoSizeText(
                            'SIGN UP',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Container(
              //   height: 50,
              //   decoration:
              //       BoxDecoration(border: Border.all(color: Colors.white)),
              //   margin: EdgeInsets.all(10),
              //   child: MaterialButton(
              //     onPressed: () {},
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Icon(FontAwesomeIcons.facebook),
              //         AutoSizeText(
              //           'CONTINUE WITH FACEBOOK',
              //           textAlign: TextAlign.end,
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 20.0,
              //             fontWeight: FontWeight.normal,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
