// ignore_for_file: must_be_immutable, unused_local_variable

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_utils/src/platform/platform.dart';

class CustomWillPopScope extends StatelessWidget {
  Widget child;
  VoidCallback? onTap;

  CustomWillPopScope({Key? key, required this.child, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final result = await showDialog<bool>(
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
                onPressed: onTap ??
                    () {
                      if (GetPlatform.isAndroid) {
                        SystemNavigator.pop();
                      } else if (GetPlatform.isIOS) {
                        SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      }
                    },
                child: AutoSizeText('Yes'),
              ),
            ],
          ),
        ).then((value)=> value ?? false);
      },
      child: child,
    );
  }
}
