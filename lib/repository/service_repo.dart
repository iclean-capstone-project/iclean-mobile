import 'package:iclean_mobile_app/models/services.dart';

abstract class ServiceRepository {
  Future<List<Service>> getService();

  Future<Service> getServiceDetails(int id);
}
