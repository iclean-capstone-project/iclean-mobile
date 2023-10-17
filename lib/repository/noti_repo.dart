import 'package:iclean_mobile_app/models/noti.dart';

abstract class NotiRepository {
  Future<List<Noti>> getNoti(int page);
  Future<void> readAll();
}
