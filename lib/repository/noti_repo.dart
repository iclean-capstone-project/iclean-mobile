import 'package:flutter/widgets.dart';
import 'package:iclean_mobile_app/models/noti.dart';

abstract class NotiRepository {
  Future<List<Noti>> getNoti(BuildContext context, int page);

  Future<void> readAll(BuildContext context);

  Future<void> maskAsRead(BuildContext context, int notiId);

  Future<void> deleteNoti(BuildContext context, int notiId);
}
