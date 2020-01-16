import 'package:http/http.dart';
import 'package:oministack_flutter_app/models/dev_model.dart';
import 'dart:async';
import 'dart:convert';

class ApiConnection {
  String baseUrl = 'http://192.180.0.102:3333/devs';

  Future<List<DevProfile>> fetchDevs() async {
    Response _response = await get('http://192.168.0.102:3333/devs');

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
}
