import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oministack_flutter_app/services/apis_http_service.dart';
import 'controllers/api_state_controller.dart';
import 'pages/HomeModule/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final apiController = Get.put(ApiControllerCubit());
  final apiHttpService = Get.put(ApiServices());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      popGesture: true,
      debugShowCheckedModeBanner: false,
      title: 'Flutter map devs',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(),
    );
  }
}
