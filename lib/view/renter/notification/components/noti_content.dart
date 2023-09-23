import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/noti.dart';
import 'package:iclean_mobile_app/utils/color_palette.dart';

import 'components/mess_noti.dart';
import 'components/noti_options.dart';
import 'components/status_noti.dart';

class NotiContent extends StatelessWidget {
  const NotiContent({
    super.key,
    required this.notis,
  });

  final List<Noti> notis;

  @override
  Widget build(BuildContext context) {
    void showNotiOptions(BuildContext context, {required Noti noti}) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) => DraggableScrollableSheet(
            initialChildSize: 0.36,
            maxChildSize: 0.36,
            minChildSize: 0.36,
            expand: false,
            builder: (context, scrollController) {
              return SingleChildScrollView(
                  controller: scrollController, child: NotiOptions(noti: noti));
            }),
      );
    }

    return Column(
      children: [
        for (int i = 0; i < notis.length; i++)
          InkWell(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: notis[i].isRead ? Colors.white : Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Row(
                children: [
                  if (notis[i].status == "unconfirm" ||
                      notis[i].status == "undone")
                    StatusNoti(
                      bgColor: Colors.deepPurple.shade200,
                      bgIconColor: ColorPalette.mainColor,
                      iconColor: Colors.white,
                      icon: Icons.check,
                    ),
                  if (notis[i].status == "done")
                    StatusNoti(
                      bgColor: Colors.greenAccent.shade100,
                      bgIconColor: Colors.greenAccent.shade400,
                      iconColor: Colors.white,
                      icon: Icons.check,
                    ),
                  if (notis[i].status == "cancel")
                    StatusNoti(
                      bgColor: Colors.redAccent.shade100,
                      bgIconColor: Colors.redAccent.shade100,
                      iconColor: Colors.redAccent,
                      icon: Icons.cancel,
                    ),
                  const SizedBox(width: 8),
                  MessNoti(notis: notis, i: i),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      showNotiOptions(context, noti: notis[i]);
                    },
                    child: const Icon(
                      Icons.more_horiz,
                      size: 24,
                    ),
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}
