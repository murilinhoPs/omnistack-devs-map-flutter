import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oministack_flutter_app/models/dev_model.dart';
import 'package:oministack_flutter_app/repositories/api_devs_repository.dart';
import 'package:oministack_flutter_app/repositories/api_devs_repository_interface.dart';
import 'package:oministack_flutter_app/services/image_url_to_bitmap.dart';
import 'package:oministack_flutter_app/pages/HomeModule/widgets/picture_map_marker.dart';

import '../../../controllers/api_state_controller.dart';

class MapMarksCubit extends GetxController {
  final markers = Map<String, Marker>().obs;

  // final _apiConnection = ApiConnection();
  final IDevsApi _devsApi = DevsApiRepository();

  final imageToBitmap = ImageUrlToBitmap();
  final picMark = PictureMark();

  Future<void> _getAllMarks(List<DevProfile> apiRes) async {
    for (var data in apiRes) {
      final _renderIcon = await imageToBitmap.avatarUrlToBitmap(data);

      final markToAdd = picMark.markToAdd(renderIcon: _renderIcon, data: data);

      markers[data.sId] = markToAdd;
    }

    Get.find<ApiControllerCubit>().changeState(FetchState.finishedLoading);
  }

  populateMarkers() async {
    markers.clear();

    var apiRes = await _devsApi.getDevs(false);

    await _getAllMarks(apiRes);
  }

  filterMarkers(String techs, double lat, double lon) async {
    markers.clear();

    var apiRes = await _devsApi.getDevs(true, techs: techs, latitude: lat, longitude: lon);

    await _getAllMarks(apiRes);
  }
}
