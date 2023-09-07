import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iclean_mobile_app/view/common/location/location_screen.dart';

import '../../../../utils/color_palette.dart';
import '../../../../widgets/my_textfield.dart';

class AddLocationScreen extends StatefulWidget {
  const AddLocationScreen({Key? key}) : super(key: key);

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
    latitude = 37.7749;
    longitude = -122.4194;
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 18,
                    ),
                  ),
                  const Text(
                    "Thêm vị trí",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Lato',
                    ),
                  ),
                  const Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                    color: Colors.white,
                  ),
                ],
              ),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              thickness: 0.5,
              color: Colors.grey[400],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LocationScreen()));
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: ColorPalette.mainColor,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                        color: ColorPalette.mainColor,
                        offset: Offset(0, 2),
                        blurRadius: 3.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      "Tiếp tục",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Lato',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
