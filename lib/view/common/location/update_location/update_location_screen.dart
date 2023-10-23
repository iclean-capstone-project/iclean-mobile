// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iclean_mobile_app/models/address.dart';
import 'package:iclean_mobile_app/services/api_location_repo.dart';
import 'package:iclean_mobile_app/widgets/confirm_dialog.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_textfield.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';

import '../location_screen.dart';

class UpdateLocationScreen extends StatefulWidget {
  const UpdateLocationScreen({
    super.key,
    required this.address,
    required this.apiLocationRepository,
  });

  final Address address;
  final ApiLocationRepository apiLocationRepository;

  @override
  State<UpdateLocationScreen> createState() => _UpdateLocationScreenState();
}

class _UpdateLocationScreenState extends State<UpdateLocationScreen> {
  final Set<Marker> _markers = {};
  late final dynamic nameController;
  late final dynamic descriptionController;
  late final double latitude;
  late final double longitude;

  @override
  void initState() {
    super.initState();
    latitude = 10.837167851789406;
    longitude = 106.83900985399156;
    nameController = TextEditingController(text: widget.address.addressName);
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
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    _markers.clear();
    super.dispose();
  }

  void _onMapTapped(LatLng latLng) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('selected_location'),
          position: latLng,
        ),
      );
    });
  }

  void updateLocation() {
    final Map<String, dynamic> dataForUpdate = {
      'locationName': nameController.text,
      'description': descriptionController.text,
      'latitude': latitude,
      'longitude': longitude,
    };

    widget.apiLocationRepository
        .updateLocation(widget.address.id!, dataForUpdate)
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
            widget.apiLocationRepository.deleteLocation(location.id!).then((_) {
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
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  height: 48,
                  child: MyTextField(
                    controller: descriptionController,
                    hintText: 'Địa chỉ cụ thể',
                  ),
                ),
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
                height: 320,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(latitude, longitude),
                    zoom: 14,
                  ),
                  markers: _markers,
                  onTap: _onMapTapped,
                ),
              ),
              const SizedBox(height: 24),
              MainColorInkWellFullSize(
                onTap: () => showConfirmationDialog(context, widget.address),
                text: "Xóa vị trí này",
                backgroundColor: Colors.white,
                textColor: Colors.red,
                borderColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10,
              offset: Offset(0.5, 3),
            )
          ],
        ),
        child: BottomAppBar(
          child: Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.background,
            child: MainColorInkWellFullSize(
              onTap: updateLocation,
              text: "Tiếp tục",
            ),
          ),
        ),
      ),
    );
  }
}
