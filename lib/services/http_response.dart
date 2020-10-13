import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:oministack_flutter_app/cubit/api_controller_cubit.dart';
import 'package:oministack_flutter_app/models/dev_model.dart';
import 'dart:async';
import 'dart:convert';

class ApiConnection {
  String baseUrl = 'https://mapdevs.herokuapp.com';

  final _apiController = Get.find<ApiControllerCubit>();

  Future<List<DevProfile>> fetchDevs() async {
    _apiController.changeState(FetchState.isLoading);

    Response _response = await get('$baseUrl/devs');

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

      throw "Can't get devs.";
    }
  }

  Future<List<DevProfile>> filterDevs(techs, lat, lon) async {
    _apiController.changeState(FetchState.isLoading);

    Response _response = await get('$baseUrl/search?techs=$techs&latitude=$lat&longitude=$lon');

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

      throw "Can't get devs.";
    }
  }
}
