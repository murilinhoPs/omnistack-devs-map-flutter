import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/api_controller_controller.dart';
import 'pages/homePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final apiController = Get.put(ApiControllerCubit());

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
