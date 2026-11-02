import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';
import '../../core/theme/app_text_styles.dart';



/// Rounded text field with soft shadow and optional prefix / suffix widgets.
class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hint,
    this.suffix,
    this.prefix,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.readOnly = false,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.textInputAction,
  });

  final String hint;
  final Widget? suffix;
  final Widget? prefix;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool readOnly;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;

  OutlineInputBorder get _border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:  BorderSide(color: AppColors.border, width: 1),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        readOnly: readOnly,
        onTap: onTap,
        validator: validator,
        inputFormatters: inputFormatters,
        textInputAction: textInputAction,
        style: AppTextStyles.body,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.body,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          prefixIcon: prefix == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(left: 20, right: 8),
                  child: prefix,
                ),
          prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          suffixIcon: suffix == null
              ? null
              : Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: suffix,
                ),
          suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          border: _border,
          enabledBorder: _border,
          focusedBorder: _border.copyWith(
            borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
          ),
        ),
      ),
    );
  }
}
