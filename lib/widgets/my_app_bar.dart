import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
    required this.text,
    this.actions,
    this.pop = true,
  });

  final bool pop;
  final String text;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    Widget? leadingWidget;
    if (pop) {
      leadingWidget = GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Icon(Icons.arrow_back_ios),
      );
    }
    return AppBar(
      title: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontFamily: 'Lato',
        ),
      ),
      centerTitle: true,
      leading: leadingWidget,
      actions: actions,
      iconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
