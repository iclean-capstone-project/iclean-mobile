import 'package:flutter/material.dart';

import '../../../utils/color_palette.dart';

class DigitTextField extends StatefulWidget {
  const DigitTextField({
    Key? key,
    required this.codeControllers,
  }) : super(key: key);

  final List<TextEditingController> codeControllers;

  @override
  State<DigitTextField> createState() => _DigitTextFieldState();
}

class _DigitTextFieldState extends State<DigitTextField> {
  late List<bool> isFocused;

  @override
  void initState() {
    super.initState();
    isFocused = List.generate(4, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        4,
        (index) => Focus(
          onFocusChange: (hasFocus) {
            setState(() {
              isFocused[index] = hasFocus;
            });
          },
          child: SizedBox(
            width: 48,
            height: 48,
            child: Container(
              decoration: BoxDecoration(
                color: isFocused[index]
                    ? ColorPalette.textFieldColorFocused
                    : ColorPalette.textFieldColorLight,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: ColorPalette.greyColor,
                ),
              ),
              child: TextFormField(
                controller: widget.codeControllers[index],
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                decoration: const InputDecoration(
                  counterText: "",
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: true,
                  fillColor: Colors.transparent,
                ),
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'Lato',
                ),
                cursorColor: Colors.black,
                onChanged: (value) {
                  if (value.isNotEmpty && index < 3) {
                    FocusScope.of(context).nextFocus();
                  } else if (value.isEmpty && index > 0) {
                    FocusScope.of(context).previousFocus();
                  }
                },
                onTap: () {
                  setState(() {
                    isFocused[index] = true;
                  });
                },
                onEditingComplete: () {
                  setState(() {
                    isFocused[index] = false;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
