import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

class DigitTextField extends StatefulWidget {
  const DigitTextField({
    super.key,
    required this.codeControllers,
  });

  final List<TextEditingController> codeControllers;

  @override
  State<DigitTextField> createState() => _DigitTextFieldState();
}

class _DigitTextFieldState extends State<DigitTextField> {
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
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
                  color: isFocused[index]
                      ? ColorPalette.mainColor
                      : ColorPalette.greyColor,
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
                ),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontFamily: 'Lato',
                ),
                cursorColor: Colors.black,
                focusNode: focusNodes[index],
                onChanged: (value) {
                  if (value.isNotEmpty && index < 3) {
                    FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                  } else if (value.isEmpty && index > 0) {
                    FocusScope.of(context).requestFocus(focusNodes[index - 1]);
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
