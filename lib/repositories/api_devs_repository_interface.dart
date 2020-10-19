import 'package:oministack_flutter_app/models/dev_model.dart';

abstract class IDevsApi {
  Future<List<DevProfile>> getDevs(bool filter, {String techs, double latitude, double longitude});
}
