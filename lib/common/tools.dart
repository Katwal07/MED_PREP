import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypton/crypton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'dart:convert' as convert;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../enums/correct_answer.dart';
import '../ui/constants/colors.dart';
import '../ui/constants/constant.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class Tools {
  // Launch URL
  static Future<void> launchURL(BuildContext context, String url) async {
    try {
      // debugger();
      await launchUrl(
        Uri.parse(url).withScheme.replace(scheme: 'https'),
        mode: LaunchMode.inAppWebView,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: AutoSizeText('Unable to launch URL')),
      );
    }
  }

  static double formatDouble(dynamic value) => value * 1.0;

  static formatDateString(String date) {
    DateTime timeFormat = DateTime.parse(date);
    final timeDif = DateTime.now().difference(timeFormat);
    return timeago.format(DateTime.now().subtract(timeDif), locale: 'en');
  }

  static void showLoadingModal() {
    EasyLoading.show(
      status: '',
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
    );
  }

  static void dismissLoadingModal() {
    EasyLoading.dismiss();
  }

  /// Chache avatar for the chat
  static getCachedAvatar(String avatarUrl) {
    return CachedNetworkImage(
      imageUrl: avatarUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
      ),
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }

  static void showErrorToast(String message) {
    Fluttertoast.showToast(
      backgroundColor: Colors.red,
      msg: 'Error: $message',
      gravity: ToastGravity.TOP,
      textColor: Colors.white,
    );
  }

  static void showSuccessToast(String message) {
    Fluttertoast.showToast(
      backgroundColor: Colors.green,
      msg: 'Success: $message',
      gravity: ToastGravity.TOP,
      textColor: Colors.white,
    );
  }
}

class Utils {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static void setStatusBarWhiteForeground(bool active) {
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(
    //     active);
  }

  static Future<dynamic> parseJsonFromAssets(String assetsPath) async {
    return rootBundle.loadString(assetsPath).then(convert.jsonDecode);
  }

  static String answerEnumToString({AnswerOption? answerOption}) {
    switch (answerOption) {
      case AnswerOption.A:
        return "A";
      case AnswerOption.B:
        return "B";
      case AnswerOption.C:
        return "C";
      case AnswerOption.D:
        return "D";
      case null:
        
    }
    return "A";
  }

  static String decryptAutoSizeText({required String text}) {
    const pKey =
        "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";

    RSAPrivateKey privateKey = RSAPrivateKey.fromString(pKey);

    final data = privateKey.decrypt(text);

    return data;
  }
}

class MedUI {
  // Colors From Brand Book
  static const secondaryBrandColor = Color(0xffd2f9f6);
  static const primaryBrandColor = Color(0xff1472ba);

  static const primaryLightColor = Color(0xff06b4d7);

  static const sideColor = Color(0xff37b883);

  static const backgroundColor = Color(0xffd2f9f6);

  static Widget AutoSizeText(String text,
      {var fontSize = textSizeMedium,
      textColor = tTextColorSecondary,
      var fontFamily = fontRegular,
      var isCentered = false,
      var maxLine = 1,
      var latterSpacing = 0.25,
      var textAllCaps = false,
      var isLongText = false}) {
    return Text(textAllCaps ? text.toUpperCase() : text,
        textAlign: isCentered ? TextAlign.center : TextAlign.start,
        maxLines: isLongText ? null : maxLine,
        style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textColor,
          fontWeight: FontWeight.bold,
          height: 1.5,
          letterSpacing: latterSpacing,
        ));
  }
}

extension UriX on Uri {
  /// Return the URI adding the http scheme if it is missing
  Uri get withScheme {
    if (hasScheme) return this;
    return Uri.parse('http://${toString()}');
  }
}
