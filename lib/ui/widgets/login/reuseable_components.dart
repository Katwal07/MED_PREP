// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../../common/tools.dart';
import '../../constants/colors.dart';
import '../../constants/constant.dart';

class T6Button extends StatefulWidget {
  String textContent;
  VoidCallback? onPressed;
  var isStroked = false;
  bool showIcon;
  Icon? icon;

  T6Button(
      {required this.textContent,
      required this.onPressed,
      this.isStroked = false,
      this.showIcon = false,
      this.icon,  Text? child});

  @override
  T6ButtonState createState() => T6ButtonState();
}

class T6ButtonState extends State<T6Button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.showIcon) widget.icon ?? Container(),
            if (widget.showIcon)
              SizedBox(
                width: 5,
              ),
            MedUI.AutoSizeText(widget.textContent,
                textColor: widget.isStroked ? tTextColorPrimary : tWhiteColor,
                isCentered: true,
                fontFamily: fontMedium,
                textAllCaps: false),
          ],
        ),
        decoration: widget.isStroked
            ? boxDecoration(
                bgColor: Colors.transparent, color: tTextColorPrimary)
            : boxDecoration(bgColor: tButtonColor, radius: 12),
      ),
    );
  }
}

Container tEditTextStyle(
  var hintText, {
  isPassword = false,
  TextEditingController? editingController,
  TextInputType textInputType = TextInputType.text,
}) {
  return Container(
    decoration:
        boxDecoration(radius: 12, showShadow: true, bgColor: tWhiteColor),
    child: TextFormField(
      controller: editingController,
      style: TextStyle(fontSize: textSizeMedium, fontFamily: fontRegular),
      obscureText: isPassword,
      keyboardType: textInputType,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(26, 18, 4, 18),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black.withOpacity(0.2)),
        filled: true,
        fillColor: tWhiteColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: tWhiteColor, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: tWhiteColor, width: 0.0),
        ),
      ),
    ),
  );
}

BoxDecoration boxDecoration(
    {double radius = 2,
    Color color = Colors.transparent,
    Color bgColor = tWhiteColor,
    var showShadow = false}) {
  return BoxDecoration(
      color: bgColor,
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      boxShadow: showShadow
          ? [BoxShadow(color: tShadowColor, blurRadius: 10, spreadRadius: 2)]
          : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}
