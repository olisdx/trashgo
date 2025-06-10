import 'package:flutter/material.dart';

import '../../../common/main_field.dart';
import '../../../common/primary_button.dart';
import '../../../core/themes/app_color.dart';

abstract class FormDialog {
  static Future<void> show(
    BuildContext context, {
    required TextEditingController title,
    required TextEditingController desc,
  }) async {
    return showDialog(
      context: context,

      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: AppColors.primaryBgWeak),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MainField(controller: title, hintText: "Title"),
                const SizedBox(height: 12),
                MainField(
                  controller: desc,
                  hintText: "Description",
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                PrimaryButton(
                  size: PrimaryButtonSize.small,
                  onPressed: () => Navigator.of(context).pop(),
                  text: "Back",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
