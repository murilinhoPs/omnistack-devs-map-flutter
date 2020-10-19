import 'package:geolocator/geolocator.dart';
import 'package:get/state_manager.dart';

class MyPositionCubit extends GetxController {
  var currentPosition = Position().obs;

  Future<void> getMyPostion() async {
    currentPosition.value = await getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
  }
}
