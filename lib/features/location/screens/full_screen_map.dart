

import 'package:mawhebtak/core/exports.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mawhebtak/features/announcement/cubit/announcement_cubit.dart';
import 'package:mawhebtak/features/casting/cubit/casting_cubit.dart';
import 'package:mawhebtak/features/jobs/cubit/jobs_cubit.dart';
import 'package:mawhebtak/features/profile/cubit/profile_cubit.dart';
import '../../../core/widgets/show_loading_indicator.dart';
import '../../calender/cubit/calender_cubit.dart';
import '../cubit/location_cubit.dart';
import '../cubit/location_state.dart';

class FullScreenMap extends StatefulWidget {
  FullScreenMap({super.key, this.type});
  String? type;
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
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        if (widget.type == 'event') {
          context.read<CalenderCubit>().locationAddressController.text =
              cubit.address2;
        }
        else if(widget.type == "add_gig"){
          context.read<CastingCubit>().locationAddressController.text =
              cubit.address2;
        }
        else if (widget.type == "job"){
          context.read<JobsCubit>().locationController.text = cubit.address2;
        }
        else if(widget.type == 'add_announcement'){
          context.read<AnnouncementCubit>().locationController.text = cubit.address2;

        } else if(widget.type == 'edit_profile'){
          context.read<ProfileCubit>().locationController.text = cubit.address2;

        }

        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("select_location".tr()),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                if (widget.type == 'event') {
                  context.read<CalenderCubit>().locationAddressController.text =
                      cubit.address2;
                }
                else if(widget.type == "add_gig"){
                  context.read<CastingCubit>().locationAddressController.text =
                      cubit.address2;
                }
                else if (widget.type == "job"){
                  context.read<JobsCubit>().locationController.text = cubit.address2;
                }
                else if(widget.type == 'add_announcement'){
                  context.read<AnnouncementCubit>().locationController.text = cubit.address2;
                }
                else if(widget.type == 'edit_profile'){
                  context.read<ProfileCubit>().locationController.text = cubit.address2;
                }
              }),
        ),
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
      ),
    );
  }
}
