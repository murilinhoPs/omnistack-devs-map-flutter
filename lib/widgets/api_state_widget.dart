import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oministack_flutter_app/controllers/api_controller_controller.dart';

class ApiStateWidget extends StatelessWidget {
  final apiController = Get.find<ApiControllerCubit>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (apiController.state.value == FetchState.isLoading)
          return Align(
            alignment: Alignment.center,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              color: Colors.white.withOpacity(0.7),
              child: CircularProgressIndicator(),
            ),
          );

        return Container();
      },
    );
  }
}
