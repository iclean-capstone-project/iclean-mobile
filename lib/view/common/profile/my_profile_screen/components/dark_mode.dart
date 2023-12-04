import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class DarkModeButton extends StatefulWidget {
  const DarkModeButton({super.key});

  @override
  State<DarkModeButton> createState() => _DarkModeButtonState();
}

class _DarkModeButtonState extends State<DarkModeButton> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(Icons.remove_red_eye_outlined),
            SizedBox(width: 16),
            Text(
              "Chế độ tối",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Lato',
              ),
            ),
          ],
        ),
        CupertinoSwitch(
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            setState(() {
              themeProvider.toggleTheme();
              themeProvider.isDarkMode = value;
            });
          },
        ),
      ],
    );
  }
}
