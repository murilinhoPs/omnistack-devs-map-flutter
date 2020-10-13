import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oministack_flutter_app/cubit/api_controller_cubit.dart';

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
        else if (apiController.state.value == FetchState.errorLoading)
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Houve um erro, tente novamente',
                style: TextStyle(color: Colors.white),
              ),
              padding: const EdgeInsets.all(8.0),
            ),
          );

        return Container();
      },
    );
  }
}
