import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DoctorLocationMap extends StatefulWidget {
  final double doctorLatitude;  // Latitude of the doctor
  final double doctorLongitude; // Longitude of the doctor

  const DoctorLocationMap({super.key, 
    required this.doctorLatitude,
    required this.doctorLongitude,
  });

  @override
  _DoctorLocationMapState createState() => _DoctorLocationMapState();
}

class _DoctorLocationMapState extends State<DoctorLocationMap> {
  late GoogleMapController _mapController;
  static const double zoomLevel = 15.0; // Set zoom level for the map

  @override
  Widget build(BuildContext context) {
    LatLng doctorPosition = LatLng(widget.doctorLatitude, widget.doctorLongitude);

    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor's Location"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: doctorPosition,
          zoom: zoomLevel,
        ),
        markers: {
          Marker(
            markerId: MarkerId("doctorLocation"),
            position: doctorPosition,
            infoWindow: InfoWindow(title: "Doctor's Location"),
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
      ),
    );
  }
}
