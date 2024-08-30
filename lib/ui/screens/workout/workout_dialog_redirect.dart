import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../package/package_Screen.dart';

class WorkoutRedirect extends StatefulWidget {
  const WorkoutRedirect({Key? key}) : super(key: key);

  @override
  _WorkoutRedirectState createState() => _WorkoutRedirectState();
}

class _WorkoutRedirectState extends State<WorkoutRedirect> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Get.to(PackageScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
