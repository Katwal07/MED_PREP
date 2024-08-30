// Start File for Dev Application

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'config/app_config.dart';
import 'locator.dart';
import 'medprepnepal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator(flavor: Flavor.LOCAL);

  await Firebase.initializeApp();

  Provider.debugCheckInvalidValueType = null;

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(Medprepnepal());
}
