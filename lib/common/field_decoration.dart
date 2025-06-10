import 'package:flutter/material.dart';

import '../core/themes/app_color.dart';
import '../core/themes/app_font.dart';

class FieldDecoration extends InputDecoration {
  @override
  Color? get focusColor => AppColors.primaryDef;

  @override
  bool get isCollapsed => true;

  @override
  bool? get isDense => true;

  @override
  bool? get filled => true;

  @override
  Color? get fillColor => Colors.white;

  @override
  TextStyle? get hintStyle =>
      Typograph.regular14.copyWith(color: AppColors.grey);

  @override
  TextStyle? get errorStyle => Typograph.regular12.copyWith(color: Colors.red);

  @override
  EdgeInsetsGeometry? get contentPadding =>
      const EdgeInsets.only(left: 0, top: 12, bottom: 12);

  @override
  InputBorder? get border => const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(24)),
  );

  @override
  InputBorder? get enabledBorder => const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(24)),
  );

  @override
  InputBorder? get focusedBorder => const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.primaryDef, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(24)),
  );

  @override
  BoxConstraints? get suffixIconConstraints {
    return const BoxConstraints(maxWidth: 40, minWidth: 40);
  }

  @override
  BoxConstraints? get prefixIconConstraints {
    return const BoxConstraints(maxWidth: 40, minWidth: 40);
  }
}
