import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/noti.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

import 'inkwell_noti_option.dart';
import 'status_noti.dart';

class NotiOptions extends StatelessWidget {
  //final Function() onTap;
  final Noti noti;
  const NotiOptions({
    Key? key,
    required this.noti,
    //required this.onTap,
  }) : super(key: key);

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
              if (noti.status == "unconfirm" || noti.status == "undone")
                StatusNoti(
                  bgColor: Colors.deepPurple.shade200,
                  bgIconColor: ColorPalette.mainColor,
                  iconColor: Colors.white,
                  icon: Icons.check,
                ),
              if (noti.status == "done")
                StatusNoti(
                  bgColor: Colors.greenAccent.shade100,
                  bgIconColor: Colors.greenAccent.shade400,
                  iconColor: Colors.white,
                  icon: Icons.check,
                ),
              if (noti.status == "cancel")
                StatusNoti(
                  bgColor: Colors.redAccent.shade100,
                  bgIconColor: Colors.redAccent.shade100,
                  iconColor: Colors.redAccent,
                  icon: Icons.cancel,
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
