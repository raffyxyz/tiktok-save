import 'package:downloader_app/const/app_colors.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final Icon icon;
  final double borderRadius;
  final bool hasError;
  final bool readOnly;
  final Function(String) onChange;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.icon,
    this.borderRadius = 25.0,
    this.hasError = false,
    this.readOnly = false,
    required this.onChange,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: TextField(
        readOnly: widget.readOnly,
        controller: widget.controller,
        obscureText: widget.obscureText,
        onChanged: (value) {
          widget.onChange(value);
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.secondaryBgColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.secondaryBgColor,
            ),
          ),
          fillColor: AppColors.secondaryBgColor,
          filled: true,
          hintText: widget.hintText,
          errorText: widget.hasError ? "Error occured!" : null,
          hintStyle: TextStyle(
            color: AppColors.secondaryTextColor,
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
          ),
          prefixIcon: widget.icon,
          prefixIconColor: MaterialStateColor.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.focused)) {
                return AppColors.secondaryTextColor;
              }
              if (states.contains(MaterialState.error)) {
                return AppColors.errorColor;
              }
              return AppColors.secondaryTextColor;
            },
          ),
        ),
      ),
    );
  }
}
