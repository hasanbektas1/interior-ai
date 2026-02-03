import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interior_ai/app/common/constants/app_colors.dart';

final class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isNumeric;
  final VoidCallback? onTap;
  final bool enabled;
  final int? maxLines;
  final Color? backgroundColor;
  final Function(String value)? onChanged;
  final Function(String value)? onSubmitted;
  final String? errorText;
  final bool obscureText;
  final bool hasBorder;
  final EdgeInsetsGeometry? contentPadding;
  final String? Function(String? value)? validator;
  final bool isError;
  final Iterable<String>? autofillHints;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;

  const AppTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.prefixIcon,
    this.isNumeric = false,
    this.onTap,
    this.enabled = true,
    this.maxLines,
    this.backgroundColor,
    this.onChanged,
    this.onSubmitted,
    this.errorText,
    this.obscureText = false,
    this.hasBorder = true,
    this.contentPadding,
    this.validator,
    this.isError = false,
    this.autofillHints,
    this.keyboardType,
    this.focusNode,
    this.onEditingComplete,
  });

  factory AppTextFormField.search({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    Color? backgroundColor,
    bool italic = false,
    VoidCallback? onTap,
    bool enabled = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Function(String value)? onChanged,
    Function(String value)? onSubmitted,
    bool hasBorder = true,
    String? Function(String? value)? validator,
  }) {
    return AppTextFormField(
      key: key,
      controller: controller,
      hintText: hintText,
      onTap: onTap,
      enabled: enabled,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      backgroundColor: backgroundColor,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      hasBorder: hasBorder,
      validator: validator,
    );
  }

  factory AppTextFormField.normal({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    Color? backgroundColor,
    bool italic = false,
    VoidCallback? onTap,
    bool enabled = true,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Function(String value)? onChanged,
    Function(String value)? onSubmitted,
    String? errorText,
    int maxLines = 1,
    EdgeInsetsGeometry? contentPadding,
    String? Function(String? value)? validator,
    bool isError = false,
    Iterable<String>? autofillHints,
    TextInputType? keyboardType,
    FocusNode? focusNode,
    VoidCallback? onEditingComplete,
  }) {
    return AppTextFormField(
      key: key,
      controller: controller,
      hintText: hintText,
      onTap: onTap,
      enabled: enabled,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      backgroundColor: backgroundColor,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
      maxLines: maxLines,
      contentPadding: contentPadding,
      validator: validator,
      isError: isError,
      autofillHints: autofillHints,
      keyboardType: keyboardType,
      focusNode: focusNode,
      onEditingComplete: onEditingComplete,
    );
  }

  factory AppTextFormField.rightIcon({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    required Widget suffixIcon,
    bool italic = false,
    VoidCallback? onTap,
    bool enabled = true,
    Function(String value)? onChanged,
    Function(String value)? onSubmitted,
    String? errorText,
    Color? backgroundColor,
    String? Function(String? value)? validator,
  }) {
    return AppTextFormField(
      key: key,
      controller: controller,
      hintText: hintText,
      suffixIcon: suffixIcon,
      onTap: onTap,
      enabled: enabled,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      backgroundColor: backgroundColor,
      validator: validator,
    );
  }

  factory AppTextFormField.numeric({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    bool italic = false,
    Widget? prefixIcon,
    VoidCallback? onTap,
    bool enabled = true,
    Function(String value)? onChanged,
    Function(String value)? onSubmitted,
    String? errorText,
    String? Function(String? value)? validator,
  }) {
    return AppTextFormField(
      key: key,
      controller: controller,
      hintText: hintText,
      isNumeric: true,
      prefixIcon: prefixIcon,
      onTap: onTap,
      enabled: enabled,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
      validator: validator,
    );
  }

  factory AppTextFormField.leftIcon({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    required Widget prefixIcon,
    bool italic = false,
    VoidCallback? onTap,
    bool enabled = true,
    Function(String value)? onChanged,
    Function(String value)? onSubmitted,
    String? errorText,
    String? Function(String? value)? validator,
  }) {
    return AppTextFormField(
      key: key,
      controller: controller,
      hintText: hintText,
      prefixIcon: prefixIcon,
      onTap: onTap,
      enabled: enabled,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      maxLines: 1,
      errorText: errorText,
      validator: validator,
    );
  }

  factory AppTextFormField.password({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    Widget? prefixIcon,
    bool italic = false,
    VoidCallback? onTap,
    bool enabled = true,
    Function(String value)? onChanged,
    Function(String value)? onSubmitted,
    String? errorText,
    bool obscureText = true,
    String? Function(String? value)? validator,
    bool isError = false,
    Iterable<String>? autofillHints,
    VoidCallback? onEditingComplete,
  }) {
    return AppTextFormField(
      key: key,
      controller: controller,
      hintText: hintText,
      prefixIcon: prefixIcon,
      onTap: onTap,
      enabled: enabled,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      maxLines: 1,
      errorText: errorText,
      obscureText: obscureText,
      validator: validator,
      isError: isError,
      autofillHints: autofillHints,
      keyboardType: TextInputType.visiblePassword,
      onEditingComplete: onEditingComplete,
    );
  }

  factory AppTextFormField.mutliLine({
    Key? key,
    required TextEditingController controller,
    required String hintText,
    bool italic = false,
    VoidCallback? onTap,
    bool enabled = true,
    int? maxLines = 2,
    Function(String value)? onChanged,
    Function(String value)? onSubmitted,
    String? errorText,
    String? Function(String? value)? validator,
  }) {
    return AppTextFormField(
      key: key,
      controller: controller,
      hintText: hintText,
      onTap: onTap,
      enabled: enabled,
      maxLines: maxLines,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      errorText: errorText,
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofillHints: autofillHints,
      focusNode: focusNode,
      onChanged: onChanged,
      validator: (value) => validator!(value),
      onEditingComplete: onEditingComplete,
      autocorrect: false,
      enableSuggestions: true,
      style: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 16,
      ),
      maxLines: maxLines,
      onTap: onTap,
      enabled: enabled,
      keyboardType: isNumeric ? TextInputType.number : keyboardType,
      inputFormatters: isNumeric
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
          : null,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        hintText: hintText,
        filled: true,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        errorText: errorText,
        hintStyle: const TextStyle(
          color: AppColors.nickel,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.normal,
          fontSize: 16,
        ),
        fillColor: isError
            ? AppColors.lavenderBlush
            : backgroundColor ?? AppColors.pureWhite,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: hasBorder
              ? const BorderSide(color: AppColors.platinum)
              : BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: hasBorder
              ? const BorderSide(color: AppColors.palePink)
              : BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: hasBorder
              ? const BorderSide(color: AppColors.platinum)
              : BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: hasBorder
              ? const BorderSide(color: AppColors.platinum)
              : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: hasBorder
              ? const BorderSide(color: AppColors.platinum)
              : BorderSide.none,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: hasBorder
              ? const BorderSide(color: AppColors.platinum)
              : BorderSide.none,
        ),
      ),
    );
  }
}
