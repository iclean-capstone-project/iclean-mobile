import 'package:iclean_mobile_app/models/address.dart';

abstract class LocationRepository {
  Future<List<Address>> getLocation();
  Future<void> setDefault(int notiId);
  Future<void> addLocation(Address newLocation);
  Future<void> updateLocation(int id, Map<String, dynamic> updatedData);
  Future<void> deleteLocation(int id);
}
