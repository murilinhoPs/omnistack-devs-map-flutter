import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oministack_flutter_app/models/dev_model.dart';
import 'package:oministack_flutter_app/services/http_response.dart';
import 'package:oministack_flutter_app/services/image_url_to_bitmap.dart';
import 'package:oministack_flutter_app/widgets/picture_map_marker.dart';

class MapMarksCubit extends Cubit<Map<String, Marker>> {
  MapMarksCubit() : super(markers);

  static Map<String, Marker> markers = {};

  final _apiConnection = ApiConnection();

  final imageToBitmap = ImageUrlToBitmap();
  final picMark = PictureMark();

  _getAllMarks(List<DevProfile> apiRes) async {
    for (var data in apiRes) {
      final _renderIcon = await imageToBitmap.avatarUrlToBitmap(data);

      final markToAdd = picMark.markToAdd(renderIcon: _renderIcon, data: data);

      markers[data.sId] = markToAdd;
    }
  }

  Future<void> populateMarkers() async {
    final apiRes = await _apiConnection.fetchDevs();

    await _getAllMarks(apiRes);

    emit(markers);
  }

  Future<void> filterMarkers(techs, lat, lon) async {
    final apiRes = await _apiConnection.filterDevs(techs, lat, lon);

    await _getAllMarks(apiRes);

    emit(markers);
  }
}
