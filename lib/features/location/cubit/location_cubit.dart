// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
import 'package:permission_handler/permission_handler.dart' as perm;

import 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  StreamSubscription<Position>? _positionStream;
  Set<Marker> positionMarkers = <Marker>{};
  Uint8List? markerIcon;

  loc.LocationData? currentLocation;
  bool isFirstTime = true;
  //! we will use this to get lat and lang that we sent and send it
  loc.LocationData? selectedLocation;

  GoogleMapController? mapController;

  String country = "country";
  String city = "city";
  String address = "address";
  String address2 = "address2";

  Future<void> checkAndRequestLocationPermission(BuildContext context) async {
    final permissionStatus = await perm.Permission.location.status;

    if (permissionStatus.isDenied) {
      final newPermissionStatus = await perm.Permission.location.request();
      if (newPermissionStatus.isGranted) {
        await _enableLocationServices(context);
      }
    } else if (permissionStatus.isGranted) {
      await _enableLocationServices(context);
    } else if (permissionStatus.isPermanentlyDenied) {
      _showLocationPermissionDialog(context);
    }
  }

  Future<void> _enableLocationServices(BuildContext context) async {
    final location = loc.Location();
    bool serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    final permissionStatus = await location.hasPermission();
    if (permissionStatus == loc.PermissionStatus.granted) {
      await _getCurrentLocation(context);
    }
  }

  Future<void> _getCurrentLocation(BuildContext context) async {
    final location = loc.Location();
    location.getLocation().then((location) async {
      currentLocation = location;
      if (isFirstTime && selectedLocation == null) {
        selectedLocation = location;
      }
      isFirstTime = false;

      await _getAddressFromLatLng(
          location.latitude ?? 0.0, location.longitude ?? 0.0);
      _setTransportationMarkers();
      log('currentLocation: ${location.latitude.toString()}, ${location.longitude.toString()}');
      emit(GetCurrentLocationState());
    });

    location.onLocationChanged.listen((newLocationData) async {
      if (currentLocation != null) {
        final distance = Geolocator.distanceBetween(
          currentLocation!.latitude ?? 0.0,
          currentLocation!.longitude ?? 0.0,
          newLocationData.latitude ?? 0.0,
          newLocationData.longitude ?? 0.0,
        );

        log('currentLocation:Update ${currentLocation?.latitude.toString()}, ${currentLocation?.longitude.toString()}');
        log('currentLocation:Selected ${selectedLocation?.latitude.toString()}, ${selectedLocation?.longitude.toString()}');

        currentLocation = newLocationData;

        emit(GetCurrentLocationState());
      }
    });
  }

  void _setTransportationMarkers() {
    positionMarkers = {
      Marker(
        markerId: const MarkerId('selectedLocation'),
        icon: markerIcon != null
            ? BitmapDescriptor.bytes(markerIcon!)
            : BitmapDescriptor.defaultMarker,
        position: LatLng(
          selectedLocation?.latitude ?? 0.0,
          selectedLocation?.longitude ?? 0.0,
        ),
      ),
    };
    emit(SetTransportationMarkersState());
  }

  Future<void> updateSelectedPositionedCamera(
      LatLng latLng, BuildContext context) async {
    if (mapController != null) {
      await mapController!.animateCamera(CameraUpdate.newLatLng(latLng));

      _setSelectedPositionedLocation(latLng, context);

      await _getAddressFromLatLng(latLng.latitude, latLng.longitude);
    }
  }

  void _setSelectedPositionedLocation(
      LatLng latLng, BuildContext? context) async {
    selectedLocation = loc.LocationData.fromMap({
      "latitude": latLng.latitude,
      "longitude": latLng.longitude,
    });

    await _getAddressFromLatLng(latLng.latitude, latLng.longitude);
    _setTransportationMarkers();
    emit(SetSelectedLocationState());
  }

  Future<String> _getAddressFromLatLng(
      double latitude, double longitude) async {
    // address = "Loading...";
    try {
      final List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final Placemark place = placemarks.first;
        country = place.country ?? "";
        city = place.locality ?? "";
        address2 =
            "${place.locality}, ${place.postalCode}, ${place.country}, ${place.administrativeArea}, ${place.name}, ${place.subLocality}";
        address = "${place.locality}, ${place.administrativeArea}";
        log('AAAAAAAAA $address2');

        emit(GetCurrentLocationAddressState());
      } else {
        emit(ErrorCurrentLocationAddressState());
      }
      return address2 == 'address2' ? '' : address2;
    } catch (e) {
      debugPrint("Error: ${e.toString()}");
      emit(ErrorCurrentLocationAddressState());
      return '';
    }
  }

  void _showLocationPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("location_required".tr()),
        content: Text("location_describtion".tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("cancel".tr()),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await perm.openAppSettings();
            },
            child: Text("open_settings".tr()),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> close() {
    _positionStream?.cancel();
    return super.close();
  }
}
