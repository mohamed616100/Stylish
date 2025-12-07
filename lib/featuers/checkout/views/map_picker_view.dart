import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class MapPickerView extends StatefulWidget {
  const MapPickerView({super.key});

  @override
  State<MapPickerView> createState() => _MapPickerViewState();
}

class _MapPickerViewState extends State<MapPickerView> {

  LatLng? _currentLatLng;
  LatLng? _selectedLatLng;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLatLng = LatLng(position.latitude, position.longitude);
      _selectedLatLng = _currentLatLng;
      _loading = false;
    });
  }

  Future<void> _confirmLocation() async {
    if (_selectedLatLng == null) return;

    final placemarks = await placemarkFromCoordinates(
      _selectedLatLng!.latitude,
      _selectedLatLng!.longitude,
    );

    final place = placemarks.first;
    final address =
        '${place.street}, ${place.locality}, ${place.country}';

    Navigator.pop(context, {
      'lat': _selectedLatLng!.latitude,
      'lng': _selectedLatLng!.longitude,
      'address': address,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Location')),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(
              target: _currentLatLng!,
              zoom: 16,
            ),
            onMapCreated: (controller) {
            },
            onCameraMove: (position) {
              _selectedLatLng = position.target;
            },
          ),

          const Center(
            child: Icon(
              Icons.location_pin,
              size: 40,
              color: Colors.red,
            ),
          ),

          Positioned(
            left: 16,
            right: 16,
            bottom: 20,
            child: ElevatedButton(
              onPressed: _confirmLocation,
              child: const Text('Confirm Location'),
            ),
          ),
        ],
      ),
    );
  }
}
