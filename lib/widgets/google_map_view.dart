// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class GoogleMapView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GoogleMap(
//       mapType: MapType.normal,
//       zoomGesturesEnabled: true,
//       myLocationButtonEnabled: false,
//       myLocationEnabled: true,
//       buildingsEnabled: true,
//       zoomControlsEnabled: false,
//       onTap: (_) {
//         _goToMyPos();
//       },
//       markers: _markers.values.toSet(),
//       initialCameraPosition: _kGooglePlex,
//       onMapCreated: (GoogleMapController controller) {
//         _controller.complete(controller);
//       },
//     );
//   }
// }
