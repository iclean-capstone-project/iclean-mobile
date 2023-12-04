// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/noti.dart';
import 'package:iclean_mobile_app/services/api_noti_repo.dart';

class NotificationsProvider extends ChangeNotifier {
  List<Noti> notifications = [];
  final ApiNotiRepository apiLocationRepository = ApiNotiRepository();

  Future<List<Noti>> fetchNotifications(BuildContext context, int page) async {
    try {
      final newNotifications =
          await apiLocationRepository.getNoti(context, page);
      notifications = newNotifications;
      notifyListeners();
      return notifications;
    } catch (e) {
      return <Noti>[];
    }
  }

  Future<void> readAll(BuildContext context) async {
    try {
      await apiLocationRepository.readAll(context);
    } catch (e) {
      print(e);
    }
  }

  Future<void> maskAsRead(BuildContext context, int notiId) async {
    try {
      await apiLocationRepository.maskAsRead(context, notiId);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteNoti(BuildContext context, int notiId) async {
    try {
      await apiLocationRepository.deleteNoti(context, notiId);
    } catch (e) {
      print(e);
    }
  }
}
