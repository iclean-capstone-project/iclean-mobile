import 'package:iclean_mobile_app/models/service.dart';

abstract class ServiceRepository {
  Future<List<Service>> getService();

  Future<Service> getServiceDetails(int id);
}
