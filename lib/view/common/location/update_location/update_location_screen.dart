import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iclean_mobile_app/models/address.dart';

import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:iclean_mobile_app/widgets/top_bar.dart';
import 'package:iclean_mobile_app/widgets/update_textfield.dart';

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
    //double baseWidth = 430;
    //double fem = MediaQuery.of(context).size.width / baseWidth;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar(text: "Chỉnh sửa vị trí"),
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: SizedBox(
                  height: 48,
                  child: UpdateTextField(
                    controller: nameController,
                    hintText: 'Tên vị trí',
                    text: widget.address.addressName,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: SizedBox(
                  height: 48,
                  child: UpdateTextField(
                    controller: descriptionController,
                    hintText: 'Địa chỉ cụ thể',
                    text: widget.address.description,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
    );
  }
}
