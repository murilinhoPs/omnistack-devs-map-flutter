import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oministack_flutter_app/cubit/my_position_cubit.dart';

class KGooglePlexCubit extends Cubit<CameraPosition> {
  KGooglePlexCubit() : super(kGooglePlex);

  static CameraPosition kGooglePlex;

  Future<void> setKGoogolePlexPos(BuildContext context) async {
    final _myPositionCubit = context.bloc<MyPositionCubit>();

    await _myPositionCubit.getMyPostion();

    kGooglePlex = CameraPosition(
      target: LatLng(_myPositionCubit.state.latitude, _myPositionCubit.state.longitude),
      zoom: 16.0,
    );

    emit(kGooglePlex);
  }
}
