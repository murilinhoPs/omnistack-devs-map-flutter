import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oministack_flutter_app/cubit/k_google_plex_cubit.dart';
import 'package:oministack_flutter_app/cubit/map_marks_cubit.dart';
import 'package:oministack_flutter_app/cubit/my_position_cubit.dart';

class Mapa extends StatelessWidget {
  final mapMarkersController = Get.find<MapMarksCubit>();

  final positionController = Get.find<MyPositionCubit>();

  final kGooglePlexController = Get.find<KGooglePlexCubit>();

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (positionController.currentPosition.value == Position())
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    'Carregando mapa',
                    style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                  ),
                )
              ],
            ),
          );
        else
          return Obx(
            () {
              return GoogleMap(
                mapType: MapType.normal,
                mapToolbarEnabled: true,
                zoomGesturesEnabled: true,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                markers: mapMarkersController.markers.values.toSet(),
                initialCameraPosition: kGooglePlexController.kGooglePlex.value,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              );
            },
          );
      },
    );
  }
}
