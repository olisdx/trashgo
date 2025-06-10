import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class CurrencyFormatter {
  static RichText formattedRP(
    int amount,
    TextStyle mainStyle,
    TextStyle smallStyle,
  ) {
    final formatted = NumberFormat(
      "Rp #,###",
      "id_ID",
    ).format(amount.toDouble());

    // Check the total number of digits
    final totalDigits = amount.toString().length;

    // Split the formatted string into main part and last three digits
    if (totalDigits > 3) {
      final parts = formatted.split('.');
      final mainPart = parts.sublist(0, parts.length - 1).join('.');
      final lastPart = parts.last;

      return RichText(
        text: TextSpan(
          children: [
            TextSpan(text: mainPart, style: mainStyle), // Main part
            TextSpan(
              text: ".$lastPart",
              style: smallStyle,
            ), // Smaller last part
          ],
        ),
      );
    }
    return RichText(text: TextSpan(text: formatted, style: mainStyle));
  }
}
