import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/noti.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

import 'inkwell_noti_option.dart';
import 'status_noti.dart';

class NotiOptions extends StatelessWidget {
  //final Function() onTap;
  final Noti noti;
  const NotiOptions({
    super.key,
    required this.noti,
    //required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -8,
            child: Container(
              width: 56,
              height: 6,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.5),
                color: ColorPalette.greyColor,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              const StatusNoti(
                bgIconColor: Colors.green,
                iconColor: Colors.white,
                icon: Icons.check,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                noti.details,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Lato',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Divider(
                thickness: 2,
              ),
              InkWellNotiOption(
                  ontap: () {},
                  icon: Icons.markunread,
                  text: "Đánh dấu đã đọc"),
              InkWellNotiOption(
                ontap: () {},
                icon: Icons.cancel,
                text: "Gỡ thông báo này",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
