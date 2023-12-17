import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iclean_mobile_app/models/address.dart';
import 'package:iclean_mobile_app/provider/loading_state_provider.dart';
import 'package:iclean_mobile_app/services/api_location_repo.dart';
import 'package:iclean_mobile_app/services/location_service.dart';

import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_textfield.dart';
import 'package:iclean_mobile_app/widgets/my_bottom_app_bar.dart';
import 'package:provider/provider.dart';

import '../location_screen.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final Set<Marker> _markers = {};
  final Completer<GoogleMapController> _controller = Completer();

  late final dynamic nameController;
  late final dynamic descriptionController;
  late final double latitude;
  late final double longitude;
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(10.837167851789406, 106.83900985399156),
    zoom: 14.4746,
  );

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

  Future<void> _addNewLocation() async {
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
    final loadingState = Provider.of<LoadingStateProvider>(context);
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
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: MyBottomAppBar(
        text: "Thêm vị trí mới",
        onTap: () async {
          loadingState.setLoading(true);
          try {
            await _addNewLocation();
          } finally {
            loadingState.setLoading(false);
          }
        },
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
