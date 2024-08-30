import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'common/pre_release_check.dart';
import 'config/app_config.dart';
import 'enums/pre_release_state.dart';
import 'firebase_options.dart';
import 'locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:auto_size_text/auto_size_text.dart';


import 'ui/constants/loading.dart'; // Import AutoSizeText

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Flavor flavor = Platform.isIOS ? Flavor.PROD : Flavor.DEV;

  setupLocator(flavor: flavor);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);


  Provider.debugCheckInvalidValueType = null;
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

      runApp(MyApp());
}




class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PreReleaseCheck preReleaseCheck = PreReleaseCheck();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: preReleaseCheck.preReleaseVersionCheck(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            home: Scaffold(
              body: kLoadingWidget(context),
            ),
          );
        }
        if (snapshot.hasData) {
          if (snapshot.data == PreReleaseState.True) {
            return App();
          } else if (snapshot.data == PreReleaseState.NoConnection) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 40.0),
                        child: AutoSizeText(
                          'No internet Connection. Please Connect to Internet',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.lightBlue,
                          ),
                          onPressed: () {
                            setState(() {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.download),
                              SizedBox(width: 10),
                              AutoSizeText(
                                'Retry',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 40.0),
                        child: AutoSizeText(
                          'As this is Pre Release Version of Application we allow to run only the latest version (${preReleaseCheck.latestVersion}). Please download it by visiting link below.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        width: 200,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Colors.lightBlue, // Background color
                          ),
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.download),
                              SizedBox(width: 10),
                              AutoSizeText(
                                'Download (${preReleaseCheck.latestVersion})',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
        return MaterialApp(
          home: Scaffold(
            body: kLoadingWidget(context),
          ),
        );
      },
    );
  }
}

class PreReleaseApp extends StatefulWidget {
  @override
  _PreReleaseAppState createState() => _PreReleaseAppState();
}

class _PreReleaseAppState extends State<PreReleaseApp> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
