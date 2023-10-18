import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iclean_mobile_app/models/address.dart';

import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:iclean_mobile_app/widgets/my_textfield.dart';

class UpdateLocationScreen extends StatefulWidget {
  const UpdateLocationScreen({super.key, required this.address});
  final Address address;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(text: "Chỉnh sửa vị trí"),
      body: Padding(
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
            Expanded(
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(latitude,
                      longitude), //Default Location: Tan Son Nhat AirPort
                  zoom: 14,
                ),
                markers: _markers,
                onTap: _onMapTapped,
              ),
            ),
          ],
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
              onTap: () {
                // Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) =>
                //                      const AddLocationScreen()));
              },
              text: "Tiếp tục",
            ),
          ),
        ),
      ),
    );
  }
}
