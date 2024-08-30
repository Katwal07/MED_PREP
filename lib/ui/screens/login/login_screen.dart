// ignore_for_file: must_be_immutable

import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:validators/validators.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/tools.dart';
import '../../../enums/viewstate.dart';
import '../../../tabbar.dart';
import '../../constants/colors.dart';
import '../../constants/constant.dart';
import '../../constants/loading.dart';
import '../../viewmodels/login_model.dart';
import '../../widgets/login/reuseable_components.dart';
import '../base_screen.dart';
import '../signup/singup_screen.dart';
import 'forget_password_screen.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: AutoSizeText('Are you sure?',
                    style: TextStyle(color: Colors.black)),
                content: AutoSizeText(
                  'Do you want to exit the App?',
                  style: TextStyle(color: Colors.black),
                ),
                actions: <Widget>[
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: AutoSizeText('No'),
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      GetPlatform.isAndroid
                          ? SystemNavigator.pop()
                          : GetPlatform.isIOS
                              ? SystemChannels.platform
                                  .invokeMethod('SystemNavigator.pop')
                              : null
                    },
                    child: AutoSizeText('Yes'),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        backgroundColor: MedUI.backgroundColor,
        body: GestureDetector(
          onTap: () {
            print(
              'Tapped',
            );
            Utils.hideKeyboard(context);
          },
          child: BaseScreen<LoginModel>(
            builder: (context, model, _) => Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    'assets/images/main_top.png',
                    width: width * 0.3,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.5),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/login_bottom.png',
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.1),
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
                    child: GestureDetector(
                      onTap: () {
                        print('Tapped');
                        Utils.hideKeyboard(context);
                      },
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
                          MedUI.AutoSizeText(
                            'Email *',
                            textColor: tTextColorPrimary,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          tEditTextStyle(
                            'Eg. johndoe@gmail.com',
                            editingController: emailController,
                            textInputType: TextInputType.emailAddress,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          MedUI.AutoSizeText('Password *',
                              textColor: tTextColorPrimary),
                          SizedBox(
                            height: 8,
                          ),
                          tEditTextStyle(
                            '********',
                            editingController: passwordController,
                            isPassword: true,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(ForgetPasswordScreen());
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              child: MedUI.AutoSizeText('Forget Password?'),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          model.state == ViewState.Busy
                              ? kLoadingWidget(context)
                              : T6Button(
                                  textContent: 'Login',
                                  onPressed: () async {
                                    // Validate Email and Password
                                    if (!isEmail(emailController.text)) {
                                      Tools.showErrorToast(
                                          'Please Enter a valid Email');
                                      return;
                                    }
                                    if (passwordController.text.isEmpty) {
                                      Tools.showErrorToast(
                                          'Please Enter a valid Password');
                                      return;
                                    }

                                    if (passwordController.text.length < 8) {
                                      Tools.showErrorToast(
                                          'Password should be at least 8 character long');
                                      return;
                                    }
                                    var loginSuccess = await model.login(
                                        emailController.text,
                                        passwordController.text);

                                    if (loginSuccess) {
                                      Get.offAll(MainTabs());
                                    }
                                  },
                                ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MedUI.AutoSizeText('New to this experience?'),
                              SizedBox(
                                width: 4,
                              ),
                              GestureDetector(
                                child: AutoSizeText(
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: textSizeMedium,
                                    color: tFromGoogle,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () async {
                                  Get.to(SingupScreen());
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
          ),
        ),
      ),
    );
  }
}

class IconFadeTransition extends StatefulWidget {
  @override
  _IconFadeTransitionState createState() => _IconFadeTransitionState();
}

class _IconFadeTransitionState extends State<IconFadeTransition>
    with TickerProviderStateMixin {
  late Timer _myTimer;

  List<String> imageList = [
    'assets/icons/anatomy.svg',
    'assets/icons/physiology.svg',
    'assets/icons/evidencebasedmedicine.svg',
    'assets/icons/microbiology.svg',
    'assets/icons/pathology.svg',
    'assets/icons/pharmacology.svg'
  ];

  var rnd = new Random();

  int selectedImageIndex = 0;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 4000),
        vsync: this,
        value: 0.2,
        lowerBound: 0.2,
        upperBound: 1);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
    _myTimer = Timer.periodic(Duration(seconds: 5), (_) {
      setState(() {
        selectedImageIndex = rnd.nextInt(imageList.length);

        _controller = AnimationController(
            duration: Duration(milliseconds: 4000),
            vsync: this,
            value: 0.1,
            lowerBound: 0.1,
            upperBound: 1);

        _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

        _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    _myTimer.cancel();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      child: FadeTransition(
        opacity: _animation,
        child: SvgPicture.asset(
          imageList[selectedImageIndex],
          // ignore: deprecated_member_use
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
        ),
      ),
    );
  }
}
