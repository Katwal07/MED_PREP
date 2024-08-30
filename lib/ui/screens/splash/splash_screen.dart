// ignore_for_file: unused_field, unnecessary_null_comparison

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../../common/constants.dart';
import '../../../common/size_config.dart';
import '../../../locator.dart';
import '../../../models/user.dart';
import '../../../services/api_service.dart';
import '../../../services/storage_service.dart';
import '../../../tabbar.dart';
import '../../constants/loading.dart';
import '../email-verification/not_verified_screen.dart';
import '../intro/intro_screen.dart';
import '../login/login_screen.dart';
import '../programSelection/programSelectionv2.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Animation animation;
  late AnimationController controller;
  late Animation<double> fadeAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 4), vsync: this);
    // animation = Tween(begin: 50.0, end: 200.0).animate(controller);
    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();

    EasyLoading.instance
      ..backgroundColor = Colors.black.withOpacity(0.4)
      ..maskColor = Colors.black.withOpacity(0.4)
      ..loadingStyle = EasyLoadingStyle.light
      ..contentPadding = EdgeInsets.all(20.0)
      ..indicatorSize = 60.0;

    Future.delayed(Duration(seconds: 4), () {
      Get.off((() => WidgetChooser()));
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    print(MediaQuery.of(context).size.height);
    SizeConfig().init(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.25),
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage('assets/images/splash_new.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 105,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/logo_transparent_1.png',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            AutoSizeText(
              'The time is now',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontFamily: 'popins',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// bottomTextController = AnimationController(
//   duration: Duration(seconds: 2),
//   vsync: this,
// );
// bottomTextAnimation =
//     Tween<double>(begin: -50, end: 50).animate(bottomTextController);
// bottomTextController.forward();
// Container(
//   child: Scaffold(
//     body: ListView(
//       children: [
//         Container(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           color: Colors.white,
//           child: Column(
//             children: [
//               Container(
//                 alignment: Alignment.topCenter,
//                 height: 10.0,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: AssetImage('assets/images/line.png'),
//                     fit: BoxFit.fitWidth,
//                   ),
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height / 2,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 5.0),
//                       child: AutoSizeText(
//                         'Welcome to',
//                         style: TextStyle(
//                           color: Color(0xFF727FC8),
//                           fontSize: 32.0,
//                           fontFamily: 'popins',
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
// AnimatedBuilder(
//   animation: animation,
//   builder: (context, child) {
//     return Container(
//       height: animation.value,
//       width: animation.value,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(
//             'assets/images/logo_transparent_1.png',
//           ),
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   },
// ),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 60.0),
//                       child: AutoSizeText(
//                         'MEDICAL PREPRATION NEPAL',
//                         style: TextStyle(
//                             color: Color(0xFF727FC8),
//                             fontSize: 16.0,
//                             fontFamily: 'popins',
//                             fontStyle: FontStyle.normal),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Stack(
//                   children: [
//                     ValueListenableBuilder(
//                       valueListenable: bottomTextAnimation,
//                       builder: (context, double value, child) {
//                         return AnimatedPositioned(
//                           duration: bottomTextController.duration,
//                           bottom: value,
//                           left: 0,
//                           right: 0,
//                           child: Center(
//                             child: Padding(
//                               padding: const EdgeInsets.only(bottom: 60.0),
//                               child: AutoSizeText(
//                                 'The Time Is Now',
//                                 style: TextStyle(
//                                     color: Color(0xFF727FC8),
//                                     fontSize: 24.0,
//                                     fontFamily: 'popins',
//                                     fontStyle: FontStyle.normal,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     ),
//   ),
// );
class WidgetChooser extends StatefulWidget {
  @override
  _WidgetChooserState createState() => _WidgetChooserState();
}

class _WidgetChooserState extends State<WidgetChooser> {
  final StorageService _storageService = locator<StorageService>();
  Future<bool> isFirstTime() async {
    bool isFirstTimeUser =
        await _storageService.getBoolFromSharefPrefs(key: IS_FIRST_TIME_USER);

    if (isFirstTimeUser == null) {
      return false;
    } else {
      return isFirstTimeUser;
    }
  }

  final _api = locator<Api>();

  // void checkForceUpdate() async {
  //   final config = await _api.getAppConfiguration();

  //   if (config != null) {
  //     // We have configuration here
  //     final deprecatedVersion = Version.parse(config.depricatedVersion);

  //     final appVersion = Version.parse(await GetVersion.projectVersion);

  //     if (config.forceUpdate && deprecatedVersion >= appVersion) {
  //       await showDialog(
  //         context: context,
  //         barrierDismissible: false,
  //         barrierColor: Theme.of(context).primaryColor.withOpacity(0.8),
  //         builder: (context) {
  //           final forceUpdateLink =
  //               Platform.isAndroid ? config.androidUrl : config.iosUrl;
  //           return WillPopScope(
  //             onWillPop: () {
  //               exit(0);
  //             },
  //             child: AlertDialog(
  //               title: AutoSizeText(
  //                 'Oops, update is required',
  //                 style: TextStyle(
  //                   fontFamily: 'GilroyBold',
  //                 ),
  //               ),
  //               content: AutoSizeText(
  //                   'Your version of App is no longer supported. Update the app to get access'),
  //               actions: <Widget>[
  //                 TextButton(
  //                   onPressed: () {
  //                     launch(forceUpdateLink);
  //                   },
  //                   child: AutoSizeText(
  //                     'UPDATE APP',
  //                   ),
  //                 )
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // checkForceUpdate();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    // return user != null && user.email != '' ? MainTabs() : HomeScreen();
    return user != null && user.email != ''
        ? user.isUserVerified == true
            ? (user.selectedProgram == null ||
                    (user.selectedProgram is String &&
                        user.selectedProgram!.isEmpty))
                ? ProgramSelectV2()
                : MainTabs()
            : NotVerifiedScreen(
                user: user,
              )
        : FutureBuilder(
            future: isFirstTime(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == true) {
                  return LoginScreen();
                }
                return IntroScreen();
              } else {
                return Scaffold(
                  body: Container(
                    color: Colors.white,
                    child: kLoadingWidget(context),
                  ),
                );
              }
            });
  }
}
