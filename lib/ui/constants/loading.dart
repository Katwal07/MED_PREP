import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Fot Loading Widget
Widget kLoadingWidget(context) => Center(
      child: SpinKitDualRing(
        color: Theme.of(context).colorScheme.secondary,
        size: 30.0,
      ),
    );
