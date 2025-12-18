import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

Widget Inputtextfiled(
    TextEditingController controller, {
      TextInputType keyboard = TextInputType.text,
      Widget? prefix,
      int maxLines = 1,
      bool enabled = true,
      bool filled = false,
      String? hint,
      String? Function(String?)? validator,
    }) {
  OutlineInputBorder border({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: color ?? AppColors.inputBg,
          width: 1.2
      ),
    );
  }

  return TextFormField(
    controller: controller,
    enabled: enabled,
    keyboardType: keyboard,
    maxLines: maxLines,
    validator:
    validator ?? (v) => v == null || v.isEmpty ? "Required field" : null,
    style: const TextStyle(
      fontSize: 16,
      color: AppColors.textPrimary,
    ),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 16,
        color: AppColors.textSecondary,
      ),
      contentPadding:
      const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      prefixIcon: prefix,
      filled: filled,
      fillColor: filled ? AppColors.inputBg : AppColors.white,
      border: border(),
      enabledBorder: border(),
      focusedBorder: border(),
      disabledBorder:
      border(color: AppColors.inputBg, ),
    ),
  );
}
