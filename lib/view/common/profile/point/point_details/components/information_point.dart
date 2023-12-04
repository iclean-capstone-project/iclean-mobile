import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/transaction.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';
import 'package:iclean_mobile_app/widgets/details_fields.dart';

class InformationPoint extends StatelessWidget {
  const InformationPoint({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Thông tin giao dịch",
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'Lato',
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DetailsContentField(
                text: 'Mã giao dịch', text2: transaction.code!),
          ),
          const Divider(
            color: ColorPalette.greyColor,
          ),
          for (int i = 0; i < transaction.service!.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  DetailsContentField(
                    text: 'Dịch vụ',
                    text2: transaction.service![i].serviceName,
                  ),
                  const SizedBox(height: 4),
                  DetailsContentField(
                    text: 'Giá',
                    text2: transaction.service![i].formatPriceInVND(),
                    color: ColorPalette.mainColor,
                    fontWeight: FontWeight.bold,
                  ),
                  if (i != transaction.service!.length - 1)
                    const SizedBox(height: 8),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
