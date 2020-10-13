import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oministack_flutter_app/cubit/api_controller_cubit.dart';
import 'package:oministack_flutter_app/cubit/location_permisson_controller.dart';
import 'package:oministack_flutter_app/cubit/my_position_cubit.dart';

class KGooglePlexCubit extends GetxController {
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
