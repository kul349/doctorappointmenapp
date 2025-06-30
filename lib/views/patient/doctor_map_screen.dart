import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  final double latitude;
  final double longitude;

  const MapScreen({super.key, required this.latitude, required this.longitude});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  BitmapDescriptor? _customMarker;

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
    _checkPermissions();
  }

  // Load a custom marker icon
  Future<void> _loadCustomMarker() async {
    _customMarker = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      'assets/doctor.jpg', // Add this image to your assets
    );
    setState(() {});
  }

  // Check and request location permissions
  Future<void> _checkPermissions() async {
    var status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      status = await Permission.locationWhenInUse.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('Location permission is required to show the map.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Doctor's Location")),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.latitude, widget.longitude),
          zoom: 14.0,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('doctor_location'),
            position: LatLng(widget.latitude, widget.longitude),
            icon: _customMarker ?? BitmapDescriptor.defaultMarker,
          ),
        },
        zoomControlsEnabled: true,
        myLocationEnabled: true, // Show user's location
        myLocationButtonEnabled: true,
        onMapCreated: (controller) {
          _mapController = controller;
        },
      ),
    );
  }
}
