// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/noti.dart';
import 'package:iclean_mobile_app/services/api_noti_repo.dart';

class NotificationsProvider extends ChangeNotifier {
  List<Noti> notifications = [];
  final ApiNotiRepository apiLocationRepository = ApiNotiRepository();

  Future<List<Noti>> fetchNotifications(int page) async {
    try {
      final newNotifications = await apiLocationRepository.getNoti(page);
      notifications = newNotifications;
      notifyListeners();
      return notifications;
    } catch (e) {
      return <Noti>[];
    }
  }

  Future<void> readAll() async {
    try {
      await apiLocationRepository.readAll();
    } catch (e) {
      print(e);
    }
  }

  Future<void> maskAsRead(int notiId) async {
    try {
      await apiLocationRepository.maskAsRead(notiId);
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteNoti(int notiId) async {
    try {
      await apiLocationRepository.deleteNoti(notiId);
    } catch (e) {
      print(e);
    }
  }
}
