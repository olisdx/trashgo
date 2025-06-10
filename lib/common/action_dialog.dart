import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../core/themes/app_color.dart';
import '../core/themes/app_font.dart';
import 'primary_button.dart';

abstract class ActionDialog {
  static Future<void> success(
    BuildContext context, {
    required String title,
    required String desc,
    String? textButton = "Back",
    bool dismissible = false,
    Function()? onTap,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: dismissible,
      builder: (context) {
        return PopScope(
          canPop: dismissible,
          child: Dialog(
            backgroundColor: Colors.white,
            insetPadding: const EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: const BorderSide(color: AppColors.primaryBgWeak),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(TablerIcons.trophy, size: 58),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Typograph.subtitle18,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    textAlign: TextAlign.center,
                    style: Typograph.regular14,
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    size: PrimaryButtonSize.small,
                    onPressed: onTap,
                    text: textButton,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future<void> failed(
    BuildContext context, {
    required String title,
    required String desc,
    String? textButton = "Back",
    String? textButtonClose,
    bool dismissible = false,
    Function()? onTap,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: dismissible,
          child: Dialog(
            backgroundColor: Colors.white,
            insetPadding: const EdgeInsets.symmetric(horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
              side: const BorderSide(color: AppColors.primaryBgWeak),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(TablerIcons.error_404, size: 58),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: Typograph.subtitle18,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    textAlign: TextAlign.center,
                    style: Typograph.regular14,
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                    size: PrimaryButtonSize.small,
                    onPressed: onTap,
                    text: textButton,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
