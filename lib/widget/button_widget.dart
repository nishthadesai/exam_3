import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final Widget label;
  final VoidCallback callback;
  final VoidCallback? onLongPress;
  final double? elevation;
  final double? height;
  final double? width;
  final double? radius;
  final double? padding;
  final Color? buttonColor;
  final TextStyle? style;

  const AppButton(
    this.label,
    this.callback, {
    super.key,
    double this.elevation = 0.0,
    this.height,
    this.radius,
    this.padding,
    this.buttonColor,
    this.style,
    this.width,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 60.h,
      child: MaterialButton(
        onLongPress: onLongPress,
        elevation: elevation,
        onPressed: callback,
        color: buttonColor,
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(radius ?? 10)),
        ),
        child: label,
      ),
    );
  }
}
