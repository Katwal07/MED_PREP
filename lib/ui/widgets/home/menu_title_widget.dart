import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class MenuTitleWidget extends StatelessWidget {
  final String menuTitleName;

  const MenuTitleWidget({Key? key, required this.menuTitleName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          width: screenSize.width * 0.9,
          child: AutoSizeText(
            menuTitleName,
            style: kMenuTitleTextStyle,
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}

TextStyle kMenuTitleTextStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: Colors.black54,
);
