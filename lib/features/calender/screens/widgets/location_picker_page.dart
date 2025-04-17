// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:mawhebtak/core/exports.dart';
// import 'package:mawhebtak/features/calender/cubit/calender_cubit.dart';
//
//
//
// class LocationPickerPage extends StatefulWidget {
//   @override
//   _LocationPickerPageState createState() => _LocationPickerPageState();
// }
//
// class _LocationPickerPageState extends State<LocationPickerPage> {
//   GoogleMapController? mapController;
//   LatLng currentLatLng = LatLng(30.0444, 31.2357); // أي موقع مبدأي (القاهرة مثلاً)
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           GoogleMap(
//             initialCameraPosition: CameraPosition(target: currentLatLng, zoom: 14),
//             onMapCreated: (controller) => mapController = controller,
//             onCameraMove: (position) => currentLatLng = position.target,
//           ),
//           const Align(
//             alignment: Alignment.center,
//             child: Icon(Icons.location_pin, size: 40, color: Colors.red),
//           ),
//           Positioned(
//             bottom: 50,
//             left: 20,
//             right: 20,
//             child: ElevatedButton(
//               child: Text("اختر هذا الموقع"),
//               onPressed: () async {
//                 context.read<CalenderCubit>().getAddressFromLatLng(
//                   currentLatLng.latitude,
//                   currentLatLng.longitude,
//                 );
//                 Navigator.pop(context);
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
// }
