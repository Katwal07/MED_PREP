import 'package:flutter/material.dart';

import 'shimmer_container.dart';

class QODShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShimmerContainer(
      height: 300.0,
      width: MediaQuery.of(context).size.width * 0.9,
    );
  }
}
