// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iclean_mobile_app/models/address.dart';
import 'package:iclean_mobile_app/provider/loading_state_provider.dart';
import 'package:iclean_mobile_app/services/api_location_repo.dart';
import 'package:iclean_mobile_app/services/location_service.dart';
import 'package:iclean_mobile_app/widgets/confirm_dialog.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_bottom_app_bar_with_two_inkwell.dart';
import 'package:iclean_mobile_app/widgets/my_textfield.dart';
import 'package:provider/provider.dart';

import '../location_screen.dart';

class UpdateLocationScreen extends StatefulWidget {
  const UpdateLocationScreen({
    super.key,
    required this.address,
  });

  final Address address;

  @override
  State<UpdateLocationScreen> createState() => _UpdateLocationScreenState();
}

class _UpdateLocationScreenState extends State<UpdateLocationScreen> {
  final Set<Marker> _markers = {};
  final Completer<GoogleMapController> _controller = Completer();
  dynamic nameController = TextEditingController();
  dynamic descriptionController = TextEditingController();
  Address? _fetchedAddress;
  double latitude = 10.837167851789406;
  double longitude = 106.83900985399156;

  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(10.837167851789406, 106.83900985399156),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    fetchAddressById(widget.address.id!).then((address) {
      if (address != null) {
        setState(() {
          _fetchedAddress = address;
          latitude = _fetchedAddress!.latitude ?? 10.837167851789406;
          longitude = _fetchedAddress!.longitude ?? 106.83900985399156;
          _kGooglePlex = CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 14.4746,
          );
          nameController = TextEditingController(text: address.addressName);
          descriptionController =
              TextEditingController(text: address.description);
          _markers.add(
            Marker(
              markerId: const MarkerId('selected_location'),
              position: LatLng(latitude, longitude),
              infoWindow: const InfoWindow(
                title: 'Your Location',
                snippet: 'This is the initial location',
              ),
            ),
          );
        });
      } else {
        setState(() {
          _fetchedAddress = address;
          latitude = _fetchedAddress!.latitude ?? 10.837167851789406;
          longitude = _fetchedAddress!.longitude ?? 106.83900985399156;
          _kGooglePlex = CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 14.4746,
          );
          nameController =
              TextEditingController(text: widget.address.addressName);
          descriptionController =
              TextEditingController(text: widget.address.description);
          _markers.add(
            Marker(
              markerId: const MarkerId('selected_location'),
              position: LatLng(latitude, longitude),
              infoWindow: const InfoWindow(
                title: 'Your Location',
                snippet: 'This is the initial location',
              ),
            ),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    _markers.clear();
    super.dispose();
  }

  void _setMarker(LatLng point) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('marker'),
          position: point,
        ),
      );
      latitude = point.latitude;
      longitude = point.longitude;
    });
  }

  Future<Address?> fetchAddressById(int id) async {
    final ApiLocationRepository repository = ApiLocationRepository();
    try {
      final locations = await repository.getLocationById(id, context);
      return locations;
    } catch (e) {
      return null;
    }
  }

  Future<void> updateLocation() async {
    final Map<String, dynamic> dataForUpdate = {
      'locationName': nameController.text,
      'description': descriptionController.text,
      'latitude': latitude,
      'longitude': longitude,
    };
    final ApiLocationRepository repository = ApiLocationRepository();
    repository
        .updateLocation(context, widget.address.id!, dataForUpdate)
        .then((_) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LocationScreen()));
    }).catchError((error) {
      print('Failed to update location: $error');
    });
  }

  void showConfirmationDialog(BuildContext context, Address location) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDialog(
          title: "Bạn có chắc chắn muốn xóa địa chỉ này?",
          confirm: "Xác nhận",
          onTap: () {
            final ApiLocationRepository repository = ApiLocationRepository();
            repository.deleteLocation(context, location.id!).then((_) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LocationScreen()));
            }).catchError((error) {
              print('Failed to delete location: $error');
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loadingState = Provider.of<LoadingStateProvider>(context);
    return Scaffold(
      appBar: const MyAppBar(text: "Chỉnh sửa vị trí"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  height: 48,
                  child: MyTextField(
                    controller: nameController,
                    hintText: 'Tên vị trí',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: MyTextField(
                        controller: descriptionController,
                        hintText: 'Địa chỉ cụ thể',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      var directions = await LocationService().getPlace(
                        descriptionController.text,
                      );
                      _goToPlace(directions);
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                height: MediaQuery.of(context).size.height * 0.55,
                child: GoogleMap(
                  initialCameraPosition: _kGooglePlex,
                  markers: _markers,
                  onTap: _setMarker,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppBarTwoInkWell(
        onTap1: () {
          showConfirmationDialog(context, widget.address);
        },
        onTap2: () async {
          loadingState.setLoading(true);
          try {
            await updateLocation();
          } finally {
            loadingState.setLoading(false);
          }
        },
        text1: "Xóa",
        text2: "Tiếp tục",
      ),
    );
  }

  Future<void> _goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12),
      ),
    );
    _setMarker(LatLng(lat, lng));
  }
}
