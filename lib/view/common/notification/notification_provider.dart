import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/noti.dart';
import 'package:iclean_mobile_app/services/api_noti_repo.dart';

class NotificationsProvider extends ChangeNotifier {
  List<Noti> notifications = [];

  Future<List<Noti>> fetchNotifications(
      ApiNotiRepository repository, int page) async {
    try {
      final newNotifications = await repository.getNoti(page);
      notifications = newNotifications;
      notifyListeners();
      return notifications;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return <Noti>[];
    }
  }

  Future<void> readAll() async {
    try {
      await ApiNotiRepository().readAll();
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> maskAsRead(int notiId) async {
    try {
      await ApiNotiRepository().maskAsRead(notiId);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> deleteNoti(int notiId) async {
    try {
      await ApiNotiRepository().deleteNoti(notiId);
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }
}
