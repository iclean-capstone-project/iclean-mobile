import 'package:flutter/material.dart';

class UpdateTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  final String text;
  final String? Function(dynamic value)? validator;

  const UpdateTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
    required this.text,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: TextFormField(
        controller: controller,
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return '$text';
              }
              return null;
            },
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          contentPadding: const EdgeInsets.only(left: 20),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.grey[500],
            fontFamily: 'Lato',
          ),
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontFamily: 'Lato',
          ),
        ),
      ),
    );
  }
}
