import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        text,
        style:  TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: 'Lato',
        ),
      ),
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios)),
      iconTheme:  IconThemeData(color: Theme.of(context).colorScheme.secondary),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
