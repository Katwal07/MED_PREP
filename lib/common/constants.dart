import 'package:flutter/material.dart';

import 'size_config.dart';

const String BITPOINTX_LOCAL_STORAGE_KEY = 'medprepnepal';

enum Env { Production, Development, LocalBikram, LocalRupak, heroku }

final currentEnv = Env.heroku;

// final API_ENDPOINT = 'http://192.168.1.116:9261/api/v1';

final API_ENDPOINT = currentEnv == Env.Production
    ? 'https://devmedprepnepal.bitpointx.com.au/api/v1'
    : currentEnv == Env.LocalBikram
        ? 'http://192.168.2.160:9261/api/v1'
        : currentEnv == Env.LocalRupak
            ? 'http://192.168.1.150:9261/api/v1'
            : currentEnv == Env.heroku
                ? 'https://medpred-dev-backend.herokuapp.com/api/v1'
                : 'https://api.medprepnepal.com/medprep-node-backend/api/v1';

String SOCKET_ENDPOINT = currentEnv == Env.Development
    ? 'https://devmedprepnepal.bitpointx.com.au'
    : currentEnv == Env.LocalBikram
        ? 'http://192.168.2.160:9261'
        : currentEnv == Env.LocalRupak
            ? 'http://192.168.1.11:9261'
            : currentEnv == Env.heroku
                ? 'https://medpred-dev-backend.herokuapp.com'
                : 'https://api.medprepnepal.com/medprep-node-backend';

// const String LOCAL_IP_ADDRESS = "http://192.168.2.241:9261";

// const String API_ENDPOINT =
// 'http://192.168.2.154:4500/api/v1';

// const String API_ENDPOINT = '$LOCAL_IP_ADDRESS/api/v1';

// const String API_ENDPOINT =
//     'https://devmedprepnepal.bitpointx.com.au/api/v1';
//
// const String SOCKET_ENDPOINT = 'http://192.168.2.154:4500';

const String ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const String REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

const String CACHED_CONFIGURATION_KEY = 'CACHED_CONFIGURATION_KEY';

const String PAYMENT_STATUS = 'PAYMENT_STATUS';

const String CACHE_NOTIFICATION_KEY = 'CACHE_NOTIFICATION_KEY';

const String CACHE_SUBJECT_KEY = 'CACHE_SUBJECT_KEY';

const String CACHE_TEXTSIZE_KEY = 'CACHE_TEXTSIZE_KEY';

const String CACHE_LIGHT_DARK_MODE_KEY = 'CACHE_LIGHT_DARK_MODE_KEY';

const String IS_FIRST_TIME_USER = 'intro3';

const String CACHED_RESULTS = 'CACHED_RESULTS';
const String RESULT_ID = 'RESULT_ID';

const kLOG_TAG = "[MedPrepNepal]";
const kLOG_ENABLE = false;

void printLog(dynamic data) {
  if (kLOG_ENABLE) {
    // ignore: avoid_print
    print("[${DateTime.now().toUtc()}]$kLOG_TAG${data.toString()}");
  }
}

const kPrimaryColor = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}

// use for rating app on store features

const kStoreIdentifier = {
  "android": "au.com.bitpointx.bitpointxportal",
  "ios": "au.com.bitpointx.bitpointxportal"
};

const kDefaultSettings = ['notifications', 'rating', 'privacy', 'about'];

const APP_VERSION_CODE = '1.0.1';
