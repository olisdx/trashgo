import 'package:flutter/material.dart';

import '../core/themes/app_color.dart';
import 'field_decoration.dart';

class MainField extends StatefulWidget {
  const MainField({
    super.key,
    this.controller,
    this.hintText,
    this.keyboardType = TextInputType.text,
    this.autovalidateMode,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.done,
    this.maxLines = 1,
  });

  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? hintText;
  final AutovalidateMode? autovalidateMode;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final Function(String)? onFieldSubmitted;

  @override
  State<MainField> createState() => _MainFieldState();
}

class _MainFieldState extends State<MainField> {
  void _onFieldSubmitted(String value) {
    if (widget.onFieldSubmitted != null) widget.onFieldSubmitted!(value);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      autovalidateMode: widget.autovalidateMode,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      focusNode: widget.focusNode,
      textAlignVertical: TextAlignVertical.center,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: _onFieldSubmitted,
      maxLines: widget.maxLines,
      decoration: FieldDecoration().copyWith(
        hintText: widget.hintText,
        prefixText: "    ",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryDef, width: 1.5),
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
      ),
    );
  }
}
