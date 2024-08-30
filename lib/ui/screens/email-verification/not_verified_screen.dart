// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../common/tools.dart';
import '../../../locator.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import '../../../tabbar.dart';
import '../login/login_screen.dart';

class NotVerifiedScreen extends StatelessWidget {
  final User user;

  Api _api = locator<Api>();

  Future<bool> checkEmailVerification() async {
    try {
      User user = await _api.getMe();
      print("This is check" + user.isUserVerified.toString());
      if (user.isUserVerified!) {
        print("This is check" + user.isUserVerified.toString());
        return true;
      } else {
        return false;
      }
    } catch (err) {
      print("This is check" + user.id!);

      return false;
    }
  }

  NotVerifiedScreen({Key? key, required this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Stack(
      fit: StackFit.expand,
      children: [
        Positioned(
          top: 0,
          left: 0,
          child: Image.asset(
            'assets/images/main_top.png',
            width: width * 0.3,
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            'assets/images/login_bottom.png',
            color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
            width: width * 0.4,
          ),
        ),
        Positioned(
          top: 45.0,
          right: 20.0,
          child: IconFadeTransition(),
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 100),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/email_not_verified.png',
                      width: 120,
                      height: 120,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AutoSizeText(
                      'Verify Your Email Address',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AutoSizeText(
                      'We now need to verify your email address. We\'ve send an email to ${user.email} to verify your address. Please click the link in that email to continue. ${user.isUserVerified}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        'Also,',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AutoSizeText(
                      'You may resend the email by clicking on the button below.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: ButtonTheme(
                              height: 45,
                              child: ElevatedButton(
                                  child: AutoSizeText(
                                    'ALREADY VERIFIED, LET ME IN.',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(
                                    Theme.of(context).colorScheme.secondary,
                                  )),
                                  onPressed: () async {
                                    bool success =
                                        await checkEmailVerification();

                                    if (success) {
                                      Tools.showSuccessToast(
                                          'Email is Verified. Lets move to next level');

                                      Future.delayed(Duration(seconds: 1), () {
                                        Get.off(MainTabs());
                                      });

                                      // Navigate to Home Screen
                                    } else {
                                      Tools.showErrorToast(
                                        'Email is not yet verified.',
                                      );
                                    }
                                  }),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: AutoSizeText(
                        'No Email Received,',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    AutoSizeText(
                      'Do not forget to check your spam folder.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: ButtonTheme(
                              height: 45,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all(
                                    Theme.of(context).colorScheme.secondary,
                                  )),
                                  child: AutoSizeText(
                                    'RESEND EMAIL CONFIRMATION',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    bool success =
                                        await _api.resendEmailVerification();

                                    if (success) {
                                      Tools.showSuccessToast(
                                          'Reset Link was send to ${user.email}. Please Check your email.');

                                      // Navigate to Home Screen
                                    } else {
                                      Tools.showErrorToast(
                                        'Something went wrong. Please try again. Also check your internet connection',
                                      );
                                    }
                                  }),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: ButtonTheme(
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                StorageService storageService =
                                    locator<StorageService>();

                                storageService.clearUser();

                                Get.offAll(LoginScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.logout),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  AutoSizeText(
                                    'LOGOUT',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                  Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
