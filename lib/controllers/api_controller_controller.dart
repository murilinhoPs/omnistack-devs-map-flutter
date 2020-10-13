import 'package:get/get.dart';
import 'package:flutter/material.dart';

enum FetchState { isLoading, finishedLoading, errorLoading }

class ApiControllerCubit extends GetxController {
  final state = FetchState.finishedLoading.obs;

  void changeState(FetchState fetchState) {
    state.value = fetchState;

    if (fetchState == FetchState.errorLoading) _showWarning();
  }

  void _showWarning() {
    GetPlatform.isAndroid
        ? Get.snackbar(
            'Erro',
            'Houve um erro ao carregar, tente novamente',
            duration: Duration(seconds: 5),
            snackPosition: SnackPosition.BOTTOM,
            backgroundGradient: null,
            backgroundColor: Colors.black.withOpacity(0.7),
            colorText: Colors.white,
            borderRadius: 0,
            snackStyle: SnackStyle.GROUNDED,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
          )
        : Get.snackbar(
            'Erro',
            'Houve um erro ao carregar, tente novamente',
            duration: Duration(seconds: 5),
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.white.withOpacity(0.7),
          );
  }
}
