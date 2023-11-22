// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/shimmer_loading.dart';
import 'package:iclean_mobile_app/widgets/title_content.dart';
import 'package:provider/provider.dart';
import 'package:iclean_mobile_app/models/noti.dart';
import 'package:iclean_mobile_app/services/api_noti_repo.dart';
import 'package:iclean_mobile_app/provider/notification_provider.dart';

import 'components/noti_content/noti_content.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future<List<Noti>> fetchNotifications(int page) async {
      final ApiNotiRepository apiNotiRepository = ApiNotiRepository();
      try {
        final newNotifications = await apiNotiRepository.getNoti(context, page);
        return newNotifications;
      } catch (e) {
        // ignore: avoid_print
        print(e);
        return <Noti>[];
      }
    }

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
                      await notificationsProvider.readAll(context);
                      await notificationsProvider.fetchNotifications(
                          context, 1);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              FutureBuilder<List<Noti>>(
                future: fetchNotifications(1),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: List.generate(5, (index) {
                          return const ListTile(
                            leading: ShimmerLoadingWidget.circular(
                                height: 40, width: 40),
                            title: ShimmerLoadingWidget.rectangular(height: 18),
                            subtitle:
                                ShimmerLoadingWidget.rectangular(height: 10),
                          );
                        }),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final notis = snapshot.data!;
                    return NotiContent(
                      notis: notis,
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
