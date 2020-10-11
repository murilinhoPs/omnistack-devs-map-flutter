import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

class MyPositionCubit extends Cubit<Position> {
  MyPositionCubit() : super(currentPosition);

  static Position currentPosition;

  Future<void> getMyPostion() async {
    currentPosition = await getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    emit(currentPosition);
  }
}
