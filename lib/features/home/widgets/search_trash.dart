import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../common/field_decoration.dart';
import '../../../core/themes/app_color.dart';

class SearchTrash extends StatefulWidget {
  const SearchTrash({
    super.key,
    this.controller,
    this.onChange,
    this.onTap,
    this.isLoading = false,
    this.onFieldSubmitted,
  });

  final TextEditingController? controller;
  final Function(dynamic)? onChange;
  final Function()? onTap;
  final bool isLoading;
  final Function(String)? onFieldSubmitted;

  @override
  State<SearchTrash> createState() => _SearchTrashState();
}

class _SearchTrashState extends State<SearchTrash> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() {});
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (widget.onChange != null) widget.onChange!(value);
    });
  }

  Widget get _suffixIcon {
    return InkWell(
      onTap: () {
        final isSearch =
            widget.controller != null ||
            widget.controller!.text.trim().isNotEmpty;

        if (isSearch && !widget.isLoading && (widget.onTap != null)) {
          widget.onTap!();
        }
        FocusScope.of(context).unfocus();
        return;
      },
      child: const Icon(TablerIcons.search, size: 28, color: AppColors.grey),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.text,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      enableSuggestions: false,
      textAlignVertical: TextAlignVertical.center,
      textInputAction: TextInputAction.search,
      onChanged: _onChanged,
      onFieldSubmitted: !widget.isLoading ? widget.onFieldSubmitted : null,
      decoration: FieldDecoration().copyWith(
        hintText: "Find Trash...",
        suffixIcon: _suffixIcon,
        prefixText: "    ",
      ),
    );
  }
}
