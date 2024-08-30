import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final Widget? child;
  final bool isLoading;
  final void Function()? onPressed;
  final Color? backgroundColor;
  final BoxDecoration? decoration;
  final Widget loadingWidget;

  const LoadingButton({
    Key? key,
    required this.isLoading,
    this.onPressed,
    this.backgroundColor,
    this.decoration,
    required this.loadingWidget,
    this.child,
  }) : super(key: key);
  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  BoxDecoration? decoration;
  Widget? loadingWidget;
  Color? textDefaultColor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    buildDecoration();
  }

  void buildDecoration() {
    final bgColor = widget.backgroundColor ?? Theme.of(context).primaryColor;

    textDefaultColor =
        (ThemeData.estimateBrightnessForColor(bgColor) == Brightness.dark)
            ? Colors.white
            : Colors.black;

    decoration = widget.decoration ??
        BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(5),
        );
  }

  @override
  Widget build(BuildContext context) {
    buildDecoration();
    return Material(
      child: DefaultTextStyle(
        style: TextStyle(color: textDefaultColor),
        child: InkWell(
          onTap: widget.isLoading ? null : widget.onPressed,
          child: AnimatedContainer(
            padding: widget.isLoading
                ? EdgeInsets.all(10)
                : EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            duration: Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            decoration: widget.isLoading
                ? decoration!.copyWith(borderRadius: BorderRadius.circular(100))
                : decoration,
            child: widget.isLoading ? loadingWidget : widget.child,
          ),
        ),
      ),
    );
  }
}
