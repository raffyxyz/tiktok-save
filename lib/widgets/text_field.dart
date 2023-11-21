import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool obscureText;
  final Icon icon;
  final double borderRadius;
  final bool hasError;
  final Function(String) onChange;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.icon,
    this.borderRadius = 25.0,
    this.hasError = false,
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
        controller: widget.controller,
        obscureText: widget.obscureText,
        onChanged: (value) {
          widget.onChange(value);
        },
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(245, 246, 248, 1.0),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromRGBO(245, 246, 248, 1.0),
            ),
          ),
          fillColor: const Color.fromRGBO(245, 246, 248, 1.0),
          filled: true,
          hintText: widget.hintText,
          errorText: widget.hasError ? "Error occured!" : null,
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontWeight: FontWeight.normal,
            fontSize: 16.0,
          ),
          prefixIcon: widget.icon,
          prefixIconColor: MaterialStateColor.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.focused)) {
                return Colors.black45;
              }
              if (states.contains(MaterialState.error)) {
                return Colors.red;
              }
              return Colors.black45;
            },
          ),
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.controller.clear();
                    });
                  },
                  icon: const Icon(Icons.clear))
              : null,
          suffixIconColor: MaterialStateColor.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.focused)) {
                return Colors.black45;
              }
              if (states.contains(MaterialState.error)) {
                return Colors.red;
              }
              return Colors.black45;
            },
          ),
        ),
      ),
    );
  }
}
