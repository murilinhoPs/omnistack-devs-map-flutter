import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:oministack_flutter_app/controllers/api_controller_controller.dart';
import 'package:oministack_flutter_app/models/dev_model.dart';
import 'dart:async';
import 'dart:convert';

class ApiConnection {
  String baseUrl = 'https://mapdevs.herokuapp.com';

  final _apiController = Get.find<ApiControllerCubit>();

  Future<List<DevProfile>> fetchDevs(bool filter,
      {String techs, double latitude, double longitude}) async {
    _apiController.changeState(FetchState.isLoading);

    String fetchUrl = '$baseUrl/devs';

    String filterUrl = '$baseUrl/search?techs=$techs&latitude=$latitude&longitude=$longitude';

    try {
      Response _response = await get(filter ? filterUrl : fetchUrl).timeout(
        Duration(seconds: 20),
        onTimeout: () {
          _apiController.changeState(FetchState.errorLoading);
          return;
        },
      );

      if (_response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(_response.body);

        List<DevProfile> devs = jsonResponse
            .map(
              (item) => (DevProfile.fromJson(item)),
            )
            .toList();

        return devs;
      } else {
        _apiController.changeState(FetchState.errorLoading);

        throw "Can't get devs on server";
      }
    } catch (e) {
      Future.delayed(Duration(seconds: 5), () {
        _apiController.changeState(FetchState.errorLoading);
      });

      throw "Can't get devs " + e.message;
    }
  }
}
