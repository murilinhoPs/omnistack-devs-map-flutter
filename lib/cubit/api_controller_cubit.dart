import 'package:get/get.dart';

enum FetchState { isLoading, finishedLoading, errorLoading }

class ApiControllerCubit extends GetxController {
  final state = FetchState.finishedLoading.obs;

  void changeState(FetchState fetchState) {
    state.value = fetchState;
  }
}
