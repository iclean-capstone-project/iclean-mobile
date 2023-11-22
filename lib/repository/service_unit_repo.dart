import 'package:flutter/widgets.dart';
import 'package:iclean_mobile_app/models/service_unit.dart';

abstract class ServiceUnitRepository {
  Future<List<ServiceUnit>> getServiceUnit(BuildContext context, int id);
}
