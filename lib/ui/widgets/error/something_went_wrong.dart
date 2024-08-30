import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../tabbar.dart';

class SomethingWentWrong extends StatelessWidget {
  final String message;

  const SomethingWentWrong(
      {Key? key, this.message = "Something Went Wrong. Please Try Again Later"})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AutoSizeText(message),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAll(() => MainTabs());
              },
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                Theme.of(context).colorScheme.secondary,
              )),
              child: AutoSizeText(
                'Back to Home',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
