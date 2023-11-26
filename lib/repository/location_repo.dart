import 'package:flutter/widgets.dart';
import 'package:iclean_mobile_app/models/address.dart';

abstract class LocationRepository {
  Future<List<Address>> getLocation(BuildContext context);
  Future<Address> getLocationById(int id, BuildContext context);
  Future<void> setDefault(BuildContext context, int notiId);
  Future<void> addLocation(BuildContext context, Address newLocation);
  Future<void> updateLocation(
      BuildContext context, int id, Map<String, dynamic> updatedData);
  Future<void> deleteLocation(BuildContext context, int id);
}
