import 'dart:convert';

import 'package:get/get.dart';
import 'package:oministack_flutter_app/controllers/api_state_controller.dart';
import 'package:oministack_flutter_app/interfaces/apis_http_interface.dart';
import 'package:http/http.dart' as http;

class ApiServices implements IApiMethods {
  final _apiController = Get.find<ApiControllerCubit>();

  @override
  void addToken(String token) {}

  @override
  Future get(String url) async {
    try {
      var response = await http.get(url).timeout(
        Duration(seconds: 20),
        onTimeout: () {
          _apiController.changeState(FetchState.errorLoading);
          return;
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);

        return jsonResponse;
      } else {
        _apiController.changeState(FetchState.errorLoading);

        throw "Returned error code from api: ${response.statusCode}";
      }
    } catch (e) {
      _apiController.changeState(FetchState.errorLoading);

      throw "There's something wrong with connection: " + e.toString();
    }
  }
}
