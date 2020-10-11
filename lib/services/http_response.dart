import 'package:http/http.dart';
import 'package:oministack_flutter_app/models/dev_model.dart';
import 'dart:async';
import 'dart:convert';

class ApiConnection {
  String baseUrl = 'http://192.168.0.102:3333';

  Future<List<DevProfile>> fetchDevs() async {
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
      throw "Can't get posts.";
    }
  }

  Future<List<DevProfile>> filterDevs(techs, lat, lon) async {
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
      throw "Can't get posts.";
    }
  }
}
