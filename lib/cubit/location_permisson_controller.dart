import 'package:geolocator/geolocator.dart';

class LocationPermissionController {
  LocationPermission _permission;

  Future<bool> getPermissions() async {
    _permission = await requestPermission();

    _permission = await checkPermission();

    if (_permission != LocationPermission.denied || _permission != LocationPermission.deniedForever)
      return true;
    else
      return false;
  }
}
