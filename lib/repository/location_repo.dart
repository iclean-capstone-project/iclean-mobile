import 'package:iclean_mobile_app/models/address.dart';

abstract class LocationRepository {
  Future<List<Address>> getNoti();
}