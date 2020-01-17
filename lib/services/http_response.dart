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

      //print(jsonResponse);

      return devs;
    } else {
      throw "Can't get posts.";
    }
  }

  Future<List<DevProfile>> filterDevs(techs, lat, lon) async {
    // var lat = '-23.5305438';
    // var lon = '-46.707409';
    // String techs = 'Flutter';
    Response _response =
        await get('$baseUrl/search?techs=$techs&latitude=$lat&longitude=$lon');

    if (_response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(_response.body);

      List<DevProfile> devs = jsonResponse
          .map(
            (item) => (DevProfile.fromJson(item)),
          )
          .toList();

      //print(jsonResponse);
      print(_response.body);
      return devs;
    }

   
  }
}
