import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iclean_mobile_app/widgets/main_color_inkwell_full_size.dart';
import 'package:iclean_mobile_app/widgets/my_textfield.dart';
import 'package:iclean_mobile_app/widgets/top_bar.dart';

import 'components/comfirm_dialog.dart';

class UpdateNewLocationScreen extends StatefulWidget {
  const UpdateNewLocationScreen({super.key});

  @override
  State<UpdateNewLocationScreen> createState() =>
      _UpdateNewLocationScreenState();
}

class _UpdateNewLocationScreenState extends State<UpdateNewLocationScreen> {
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

  void _confirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => const ConfirmDialog(),
    );
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
              //TopBar
              const TopBar(text: "Thêm vị trí"),

              //NameAddress TextField
              Padding(
                padding: const EdgeInsets.only(top: 24),
                child: SizedBox(
                  height: 48,
                  child: MyTextField(
                    controller: nameController,
                    hintText: 'Tên vị trí',
                  ),
                ),
              ),

              //DiscriptionAddress TextField
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

              //Divider
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ),
              ),

              //GG map
              Expanded(
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: MainColorInkWellFullSize(
                onTap: _confirmDialog,
                text: "Tiếp tục",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
