import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:validators/validators.dart';

import '../../../common/tools.dart';
import '../../../locator.dart';
import '../../../services/api_service.dart';
import '../../constants/colors.dart';
import '../../constants/constant.dart';
import '../../widgets/login/reuseable_components.dart';
import 'login_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  Api _api = locator<Api>();

  GlobalKey<FormState> _formsKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MedUI.backgroundColor,
      body: Stack(
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
            child: Container(
              height: height,
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: _formsKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/logo_transparent_1.png',
                          width: width / 2.0,
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    MedUI.AutoSizeText('Email *', textColor: tTextColorPrimary),
                    SizedBox(
                      height: 8,
                    ),
                    tEditTextStyle('Eg. joshdoe@gmail.com',
                        editingController: emailController),
                    SizedBox(
                      height: 16,
                    ),
                    T6Button(
                      textContent: 'Forget Password',
                      onPressed: () async {
                        var email = emailController.text.trim();

                        if (email.isEmpty || !isEmail(email)) {
                          Tools.showErrorToast('Please Enter a valid Email.');
                          return;
                        }

                        var success = await _api.forgetPassword(email: email);

                        if (success) {
                          Tools.showSuccessToast(
                              'Email was sent successfully to $email - Please check your mailbox.');

                          Get.off(LoginScreen());

                          emailController.clear();
                          return;
                        } else {
                          Tools.showErrorToast(
                              'Email Reset Failed. Please try again also check your email.');
                          return;
                        }
                        // Get.defaultDialog(
                        //     title: 'Beta Version Alert!!',
                        //     content: AutoSizeText(
                        //       'Forget Password is not allowed in this  version.',
                        //       style: TextStyle(
                        //         color: Colors.black45,
                        //       ),
                        //     ),
                        //     radius: 5,
                        //     confirm: ElevatedButton(
                        //       color: tButtonColor,
                        //       child: AutoSizeText(
                        //         'OK',
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //         ),
                        //       ),
                        //       onPressed: () {
                        //         Get.back();
                        //       },
                        //     ));
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MedUI.AutoSizeText('I remember login credentials.'),
                        SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          child: AutoSizeText(
                            'Log In',
                            style: TextStyle(
                                fontSize: textSizeMedium,
                                color: tFromGoogle,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            Get.offAll(LoginScreen());
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
