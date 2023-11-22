// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/noti.dart';
import 'package:iclean_mobile_app/provider/notification_provider.dart';

import 'components/mess_noti.dart';
import 'components/noti_options.dart';
import 'components/status_noti.dart';

class NotiContent extends StatelessWidget {
  const NotiContent({
    super.key,
    required this.notis,
    required this.notificationsProvider,
  });

  final List<Noti> notis;
  final NotificationsProvider notificationsProvider;

  void showNotiOptions(BuildContext context, Noti noti) {
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
                controller: scrollController,
                child: NotiOptions(
                  noti: noti,
                  maskAsRead: () async {
                    if (noti.isRead == false) {
                      await notificationsProvider.maskAsRead(context, noti.id);
                      await notificationsProvider.fetchNotifications(
                          context, 1);
                      Navigator.pop(context);
                    }
                  },
                  delete: () async {
                    await notificationsProvider.deleteNoti(context, noti.id);
                    await notificationsProvider.fetchNotifications(context, 1);
                    Navigator.pop(context);
                  },
                ));
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < notis.length; i++)
          InkWell(
            onTap: () async {
              if (notis[i].isRead == false) {
                await notificationsProvider.maskAsRead(context, notis[i].id);
                await notificationsProvider.fetchNotifications(context, 1);
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: notis[i].isRead
                    ? Theme.of(context).colorScheme.background
                    : Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Row(
                children: [
                  const StatusNoti(
                    bgIconColor: Colors.green,
                    iconColor: Colors.white,
                    icon: Icons.check,
                  ),
                  const SizedBox(width: 8),
                  MessNoti(notis: notis, i: i),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      showNotiOptions(context, notis[i]);
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
