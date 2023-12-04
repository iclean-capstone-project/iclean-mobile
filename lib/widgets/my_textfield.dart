import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? textType;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.textType,
    this.validator,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: textType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: ColorPalette.greyColor,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(
            color: ColorPalette.mainColor,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.primary,
        suffixIcon: suffixIcon,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: ColorPalette.greyColor,
          fontFamily: 'Lato',
        ),
      ),
      style: const TextStyle(
        fontSize: 16,
        fontFamily: 'Lato',
      ),
      cursorColor: Theme.of(context).colorScheme.secondary,
    );
  }
}
