import 'package:flutter/material.dart';

import '../../../helper/theme.dart';

class AppButton extends StatelessWidget {
  const AppButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor,
      this.borderColor,
      this.foregroundColor,
      this.textColor,
      this.fontSize,
      this.height,
      this.width,
      this.borderRadius,
      this.isOutLined});
  final void Function()? onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? foregroundColor;
  final Color? textColor;
  final double? fontSize;
  final double? width;
  final double? height;
  final double? borderRadius;
  final bool? isOutLined;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 150,
      height: height ?? 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: foregroundColor ?? Colors.white,
          backgroundColor: backgroundColor ?? AppColors.primary, // Text color
          elevation: isOutLined == true ? 0 : 4,
          // Button elevation
          shape: RoundedRectangleBorder(
            side: isOutLined == true
                ? BorderSide(color: borderColor ?? Colors.black)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(
                borderRadius ?? 5.0), // Adjust the radius as needed
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: fontSize ?? 16,
              color: textColor ?? (isOutLined == true ? Colors.black : null),
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
