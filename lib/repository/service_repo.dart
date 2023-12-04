import 'package:flutter/widgets.dart';
import 'package:iclean_mobile_app/models/service.dart';

abstract class ServiceRepository {
  Future<List<Service>> getService(BuildContext context);

  Future<Service> getServiceDetails(BuildContext context, int id);
}
