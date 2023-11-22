import 'package:flutter/material.dart';
import 'package:iclean_mobile_app/models/address.dart';
import 'package:iclean_mobile_app/services/api_location_repo.dart';

class LocationsProvider extends ChangeNotifier {
  List<Address> locations = [];

  Future<List<Address>> fetchLocation(
      BuildContext context, ApiLocationRepository repository) async {
    try {
      final newLocations = await repository.getLocation(context);
      locations = newLocations;
      notifyListeners();
      return locations;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return <Address>[];
    }
  }
}
