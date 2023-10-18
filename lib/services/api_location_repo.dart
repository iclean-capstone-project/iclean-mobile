import 'package:iclean_mobile_app/models/address.dart';
import 'package:iclean_mobile_app/repository/location_repo.dart';
import 'package:iclean_mobile_app/services/constant.dart';

class ApiLocationRepository implements LocationRepository {

  static const String urlConstant = "${BaseConstant.baseUrl}/address";

  @override
  Future<List<Address>> getNoti() async {
    throw UnimplementedError();
  }

}