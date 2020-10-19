import 'package:get/get.dart';
import 'package:oministack_flutter_app/controllers/api_state_controller.dart';
import 'package:oministack_flutter_app/models/dev_model.dart';
import 'package:oministack_flutter_app/repositories/api_devs_repository_interface.dart';
import 'package:oministack_flutter_app/services/apis_http_service.dart';

class DevsApiRepository implements IDevsApi {
  final _apiServices = Get.find<ApiServices>();
  final _apiController = Get.find<ApiControllerCubit>();

  String baseUrl = 'https://mapdevs.herokuapp.com';

  @override
  Future<List<DevProfile>> getDevs(bool filter,
      {String techs, double latitude, double longitude}) async {
    _apiController.changeState(FetchState.isLoading);

    String fetchUrl = '$baseUrl/devs';

    String filterUrl = '$baseUrl/search?techs=$techs&latitude=$latitude&longitude=$longitude';

    var _response = await _apiServices.get(filter ? filterUrl : fetchUrl).timeout(
      Duration(seconds: 20),
      onTimeout: () {
        _apiController.changeState(FetchState.errorLoading);
        return;
      },
    );

    List<dynamic> newResponse = _response;

    List<DevProfile> devs = newResponse
        .map(
          (item) => (DevProfile.fromJson(item)),
        )
        .toList();

    return devs;
  }
}
