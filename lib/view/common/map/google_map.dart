// ignore_for_file: null_argument_to_non_null_type
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iclean_mobile_app/services/components/constant.dart';
import 'package:iclean_mobile_app/widgets/my_app_bar.dart';
import 'package:location/location.dart';

class GoogleMapTrackingPage extends StatefulWidget {
  const GoogleMapTrackingPage(
      {Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  State<GoogleMapTrackingPage> createState() => GoogleMapTrackingPageState();
  final double latitude;
  final double longitude;
}

class GoogleMapTrackingPageState extends State<GoogleMapTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();
  late LatLng destination =
      const LatLng(10.837167851789406, 106.83900985399156);
  late LatLng sourceLocation;
  double zoom = 13.5;
  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  Future<void> checkPermissionsAndLoadMap() async {
    Location location = Location();
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      bool serviceRequested = await location.requestService();
      if (!serviceRequested) {
        Navigator.pop(context);
        return;
      }
    }

    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        Navigator.pop(context);
        return;
      }
    }
    currentLocation = await location.getLocation();
    loadMarkerIcons();
    sourceLocation =
        LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
    getPolyPoints();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      Location location = Location();
      currentLocation = await location.getLocation();
      location.onLocationChanged.listen((newLoc) {
        setState(() {
          currentLocation = newLoc;
        });
        _updateCameraPosition(newLoc.latitude!, newLoc.longitude!, zoom);
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  void _updateCameraPosition(double latitude, double longitude, double zoom) {
    if (_controller.isCompleted) {
      _controller.future.then((controller) {
        controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(latitude, longitude), zoom: zoom),
        ));
      });
    }
  }

  // Separate polyline-related functionalities
  Future<void> getPolyPoints() async {
    try {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        BaseConstant.google_api_key,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude),
      );

      if (result.points.isNotEmpty) {
        setState(() {
          polylineCoordinates = result.points
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();
        });
      } else {
        print('Result Poly: ' + result.errorMessage!);
      }
    } catch (e) {
      print('Error fetching polyline points: $e');
    }
  }

  // Load custom marker icons asynchronously
  Future<void> loadMarkerIcons() async {
    try {
      List<Future<BitmapDescriptor>> futures = [
        BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_source.png"),
        BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_destination.png"),
        BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/Pin_current_location.png"),
      ];
      List<BitmapDescriptor> icons = await Future.wait(futures);
      setState(() {
        sourceIcon = icons[0];
        destinationIcon = icons[1];
        currentLocationIcon = icons[2];
      });
    } catch (e) {
      print('Error loading marker icons: $e');
    }
  }

  @override
  void initState() {
    destination = LatLng(widget.latitude, widget.longitude);
    checkPermissionsAndLoadMap();
    super.initState();
  }

  @override
  void dispose() {
    _controller.complete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        text: "Chỉ đường",
      ),
      body: currentLocation == null
          ? const Center(child: Text("Loading..."))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                zoom: zoom,
              ),
              polylines: {
                Polyline(
                    polylineId: const PolylineId("route"),
                    points: polylineCoordinates,
                    color: BaseConstant.primaryColor,
                    width: 6)
              },
              markers: {
                Marker(
                  markerId: const MarkerId("currentLocation"),
                  icon: currentLocationIcon,
                  position: LatLng(
                      currentLocation!.latitude!, currentLocation!.longitude!),
                ),
                Marker(
                  markerId: const MarkerId("source"),
                  icon: sourceIcon,
                  position: sourceLocation,
                ),
                Marker(
                  markerId: const MarkerId("destination"),
                  icon: destinationIcon,
                  position: destination,
                )
              },
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
              onCameraMove: (CameraPosition position) {
                setState(() {
                  zoom = position.zoom;
                });
              },
            ),
    );
  }
}
