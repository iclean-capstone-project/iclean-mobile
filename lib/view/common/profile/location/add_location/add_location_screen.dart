import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iclean_mobile_app/models/address.dart';
import 'package:iclean_mobile_app/services/api_location_repo.dart';

import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_textfield.dart';
import 'package:iclean_mobile_app/widgets/my_bottom_app_bar.dart';

import '../location_screen.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
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
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    _markers.add(
      Marker(
        markerId: const MarkerId('selected_location'),
        position: LatLng(latitude,
            longitude), // Replace with desired initial latitude and longitude
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

  void _addNewLocation() {
    // Get input values from text fields
    String locationName = nameController.text;
    String description = descriptionController.text;

    // Create a new Address object
    Address newLocation = Address(
      id: null,
      longitude: longitude,
      latitude: latitude,
      addressName: locationName,
      description: description,
      isDefault: false,
    );
    // Pass newLocation to your addLocation function
    final ApiLocationRepository repository = ApiLocationRepository();
    repository.addLocation(context, newLocation).then((_) {
      // Handle success, for example, by navigating to a new screen
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const LocationScreen()));
    }).catchError((error) {
      // Handle the error, for example, by displaying an error message
      // ignore: avoid_print
      print('Failed to add location: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: "Thêm vị trí mới"),
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(
        text: "Thêm vị trí mới",
        onTap: _addNewLocation,
      ),
    );
  }
}
