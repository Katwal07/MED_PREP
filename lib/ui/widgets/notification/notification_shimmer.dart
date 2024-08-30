import 'package:flutter/material.dart';

import '../shimmer/shimmer_container.dart';

class NotificationShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: ShimmerContainer(
            height: screenSize.height * 0.15,
            width: screenSize.width,
            radius: 10.0,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
