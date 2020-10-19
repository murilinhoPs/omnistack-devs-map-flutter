import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oministack_flutter_app/controllers/api_state_controller.dart';
import 'package:oministack_flutter_app/pages/HomeModule/controllers/location_permisson_controller.dart';
import 'package:oministack_flutter_app/pages/HomeModule/controllers/my_position_controller.dart';

class KGooglePlexCubit {
  final _myPositionCubit = Get.find<MyPositionCubit>();

  final _locationPermisson = LocationPermissionController();

  final kGooglePlex = CameraPosition(target: LatLng(0, 0)).obs;

  Future<void> setKGooglePlexPos() async {
    if (await _locationPermisson.getPermissions()) {
      await _myPositionCubit.getMyPostion();

      final newPosition = _myPositionCubit.currentPosition.value;

      kGooglePlex.value = CameraPosition(
        target: LatLng(newPosition.latitude, newPosition.longitude),
        zoom: 16.0,
      );
    } else
      Get.find<ApiControllerCubit>().changeState(FetchState.errorLoading);
  }
}
