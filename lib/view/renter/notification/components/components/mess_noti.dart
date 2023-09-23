import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/noti.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:intl/intl.dart';

class MessNoti extends StatelessWidget {
  const MessNoti({
    super.key,
    required this.notis,
    required this.i,
  });

  final List<Noti> notis;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notis[i].details,
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontFamily: 'Lato',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            DateFormat('MMM d, yyyy | hh:mm aaa').format(notis[i].timestamp),
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'Lato',
              color: ColorPalette.greyColor,
            ),
          ),
        ],
      ),
    );
  }
}
