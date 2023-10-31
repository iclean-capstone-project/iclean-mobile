import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/title_content.dart';
import 'package:provider/provider.dart';
import 'package:iclean_mobile_app/models/noti.dart';
import 'package:iclean_mobile_app/services/api_noti_repo.dart';
import 'package:iclean_mobile_app/view/common/notification/notification_provider.dart';

import 'components/noti_content.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Noti>> fetchNotifications(
        ApiNotiRepository repository, int page) async {
      try {
        final newNotifications = await repository.getNoti(page);
        //print("Notifications: $newNotifications");
        return newNotifications;
      } catch (e) {
        // ignore: avoid_print
        print(e);
        return <Noti>[];
      }
    }

    final ApiNotiRepository apiNotiRepository = ApiNotiRepository();
    final notificationsProvider = Provider.of<NotificationsProvider>(context);
    return Scaffold(
      appBar: const MyAppBar(text: 'Thông báo'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: TitleContent(
                    text1: "Thông báo",
                    text2: "Đọc hết",
                    onTap: () async {
                      await notificationsProvider.readAll();
                      //After marking notifications as read, fetch notifications again
                      await notificationsProvider.fetchNotifications(
                          apiNotiRepository, 1);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FutureBuilder<List<Noti>>(
                // future: notificationsProvider.fetchNotifications(
                //     apiNotiRepository, 1),
                future: fetchNotifications(apiNotiRepository, 1),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final notis = snapshot.data!;
                    return NotiContent(
                      notis: notis,
                      apiNotiRepository: apiNotiRepository,
                      notificationsProvider: notificationsProvider,
                    );
                  } else {
                    return const Text('No notifications found.');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
