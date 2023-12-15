import 'package:flutter/material.dart';
import 'inkwell_loading.dart';

class MyBottomAppBarLoading extends StatelessWidget {
  const MyBottomAppBarLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10,
            offset: Offset(0.5, 3),
          )
        ],
      ),
      child: BottomAppBar(
        child: Container(
          padding: const EdgeInsets.all(16),
          color: Theme.of(context).colorScheme.background,
          child: const InkWellLoading(),
        ),
      ),
    );
  }
}
