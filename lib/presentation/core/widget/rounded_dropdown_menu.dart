import 'package:flutter/material.dart';

import '../style/size_wrapper_extension.dart';

class RoundedDropdownMenu<T> extends StatelessWidget {
  final String labelText;
  final double? borderRadius;
  final Function(T?) onSelected;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;

  const RoundedDropdownMenu({
    super.key,
    required this.labelText,
    this.borderRadius,
    required this.onSelected,
    required this.dropdownMenuEntries,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      label: Text(labelText),
      expandedInsets: EdgeInsets.zero,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 50.r),
        ),
      ),
      onSelected: onSelected,
      dropdownMenuEntries: dropdownMenuEntries,
    );
  }
}
