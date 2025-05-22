// ignore_for_file: deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:mawhebtak/core/exports.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/widgets/show_loading_indicator.dart';
import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';

class FullScreenMap extends StatefulWidget {
  const FullScreenMap({super.key});

  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context
            .read<LocationCubit>()
            .checkAndRequestLocationPermission(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    LocationCubit cubit = context.read<LocationCubit>();
    return Scaffold(
      appBar: AppBar(title: Text("select_location".tr())),
      body: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          return cubit.selectedLocation == null
              ? const Center(child: CustomLoadingIndicator())
              : GoogleMap(
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      cubit.selectedLocation?.latitude ?? 0.0,
                      cubit.selectedLocation?.longitude ?? 0.0,
                    ),
                    zoom: 12,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    cubit.mapController = controller;
                  },
                  markers: cubit.positionMarkers,
                  onTap: (LatLng latLng) =>
                      cubit.updateSelectedPositionedCamera(latLng, context),
                );
        },
      ),
    );
  }
}
