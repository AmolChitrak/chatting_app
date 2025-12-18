import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

Widget appDropdown(
    String? value,
    List<String> items,
    ValueChanged<String?> onChanged, {
      String? hint,
    }) {
  OutlineInputBorder border({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: color ?? AppColors.inputBg,
        width: 1.2,
      ),
    );
  }

  return DropdownButtonFormField<String>(
    value: value,
    icon: Icon(
      Icons.keyboard_arrow_down,
      color: AppColors.icon,
    ),
    items: items
        .map(
          (e) => DropdownMenuItem<String>(
        value: e,
        child: Text(
          e,
          style: const TextStyle(fontSize: 16),
        ),
      ),
    )
        .toList(),
    onChanged: onChanged,
    validator: (v) => v == null ? "Required field" : null,
    decoration: InputDecoration(
      hintText: hint,
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: border(),
      enabledBorder: border(),
      focusedBorder: border(),
      errorBorder: border(color: Colors.redAccent),
    ),
  );
}
