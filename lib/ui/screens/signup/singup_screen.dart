import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:validators/validators.dart';
import '../../../common/tools.dart';
import '../../../enums/viewstate.dart';
import '../../../tabbar.dart';
import '../../constants/colors.dart';
import '../../constants/constant.dart';
import '../../constants/loading.dart';
import '../../viewmodels/signup_model.dart';
import '../../widgets/login/reuseable_components.dart';
import '../base_screen.dart';
import '../login/login_screen.dart';

class SingupScreen extends StatefulWidget {
  @override
  _SingupScreenState createState() => _SingupScreenState();
}

class _SingupScreenState extends State<SingupScreen> {
  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: MedUI.backgroundColor,
      body: BaseScreen<SignupModel>(
        builder: (context, model, child) => Stack(
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
                      height: 20,
                    ),
                    MedUI.AutoSizeText('Full Name *',
                        textColor: tTextColorPrimary),
                    SizedBox(
                      height: 6,
                    ),
                    tEditTextStyle('Eg. John Doe',
                        editingController: _nameController),
                    SizedBox(
                      height: 16,
                    ),
                    MedUI.AutoSizeText('Email *', textColor: tTextColorPrimary),
                    SizedBox(
                      height: 8,
                    ),
                    tEditTextStyle('Eg. johndoe@gmail.com',
                        editingController: _emailController),
                    SizedBox(
                      height: 16,
                    ),
                    MedUI.AutoSizeText('Password *',
                        textColor: tTextColorPrimary),
                    SizedBox(
                      height: 8,
                    ),
                    tEditTextStyle('********',
                        isPassword: true,
                        editingController: _passwordController),
                    SizedBox(
                      height: 16,
                    ),
                    MedUI.AutoSizeText('Confirm Password *',
                        textColor: tTextColorPrimary),
                    SizedBox(
                      height: 8,
                    ),
                    tEditTextStyle('********',
                        isPassword: true,
                        editingController: _confirmPasswordController),
                    SizedBox(
                      height: 16,
                    ),
                    model.state == ViewState.Busy
                        ? kLoadingWidget(context)
                        : T6Button(
                            textContent: 'Sign Up',
                            onPressed: () async {
                              if (_nameController.text.isEmpty) {
                                Tools.showErrorToast('Please enter a name');
                                return;
                              }

                              if (!isEmail(_emailController.text)) {
                                Tools.showErrorToast(
                                    'Please enter a valid email address');

                                return;
                              }

                              if (_passwordController.text.isEmpty) {
                                Tools.showErrorToast('Please enter a password');

                                return;
                              }

                              if (_passwordController.text.length < 8) {
                                Tools.showErrorToast(
                                    'Password should be at least 8 character long.');

                                return;
                              }

                              if (_passwordController.text !=
                                  _confirmPasswordController.text) {
                                Tools.showErrorToast('Password are not same.');

                                return;
                              }

                              var signupSuccess = await model.signup(
                                nameText: _nameController.text,
                                emailText: _emailController.text,
                                passwordText: _passwordController.text,
                                confirmPasswordText:
                                    _confirmPasswordController.text,
                              );

                              if (signupSuccess) {
                                Get.off(() => MainTabs());
                              }
                            },
                          ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MedUI.AutoSizeText('Already did this?'),
                        SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          child: AutoSizeText(
                            'Log In',
                            style: TextStyle(
                              fontSize: textSizeMedium,
                              color: tFromGoogle,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () {
                            Get.offAll(() => LoginScreen());
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
