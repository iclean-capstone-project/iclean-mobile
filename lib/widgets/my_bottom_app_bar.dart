import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/provider/loading_state_provider.dart';
import 'package:provider/provider.dart';

import 'inkwell_loading.dart';
import 'main_color_inkwell_full_size.dart';

class MyBottomAppBar extends StatelessWidget {
  const MyBottomAppBar({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final loadingState = Provider.of<LoadingStateProvider>(context);
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
          child: loadingState.isLoading
              ? const InkWellLoading()
              : MainColorInkWellFullSize(
                  onTap: onTap,
                  text: text,
                ),
        ),
      ),
    );
  }
}
