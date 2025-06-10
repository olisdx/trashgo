import 'package:flutter/material.dart';

import '../core/themes/app_color.dart';
import '../core/themes/app_font.dart';

/// big: 72, medium: 48, small: 42
enum PrimaryButtonSize { big, medium, small }

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    this.bgColor = AppColors.primaryDef,
    this.disableColor = AppColors.primaryDef,
    this.textColor = Colors.white,
    this.width = double.maxFinite,
    this.size = PrimaryButtonSize.medium,
    this.radius = 12,
    this.onPressed,
    this.isLoading = false,
    this.text,
  });

  final Color bgColor;
  final Color disableColor;
  final Color textColor;
  final String? text;
  final double width;
  final double radius;
  final bool isLoading;
  final PrimaryButtonSize size;
  final Function()? onPressed;

  double get _height {
    if (size == PrimaryButtonSize.big) return 72;
    if (size == PrimaryButtonSize.medium) return 48;
    return 42;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: disableColor,
        disabledForegroundColor: AppColors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        elevation: 0,
        backgroundColor: bgColor,
        foregroundColor: textColor,
        minimumSize: Size(width, _height),
        textStyle: Typograph.label14,
      ),
      onPressed:
          (onPressed == null || isLoading)
              ? null
              : () async => await onPressed!(),
      child:
          isLoading
              ? SizedBox(
                width: 20,
                height: 20,
                child: Center(
                  child: CircularProgressIndicator(
                    color: textColor,
                    strokeWidth: 2,
                  ),
                ),
              )
              : Text(text ?? "Next"),
    );
  }
}
