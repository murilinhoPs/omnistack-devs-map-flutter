import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oministack_flutter_app/cubit/k_google_plex_cubit.dart';
import 'package:oministack_flutter_app/cubit/map_marks_cubit.dart';
import 'package:oministack_flutter_app/cubit/my_position_cubit.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  CameraPosition _kGooglePlex;

  Completer<GoogleMapController> _controller = Completer();

  LocationPermission _permission;

  TextEditingController _textController = TextEditingController();

  _goToMyPos() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(_kGooglePlex),
    );
  }

  _getMyPos() async {
    final _myPositionCubit = context.bloc<MyPositionCubit>();

    _permission = await requestPermission();

    _permission = await checkPermission();

    if (_permission != LocationPermission.denied ||
        _permission != LocationPermission.deniedForever) {
      await _myPositionCubit.getMyPostion();

      setState(() {
        _kGooglePlex = CameraPosition(
          target: LatLng(_myPositionCubit.state.latitude, _myPositionCubit.state.longitude),
          zoom: 16.0,
        );
      });

      // await context.bloc<KGooglePlexCubit>().setKGoogolePlexPos(context);
    }
  }

  initStateAsync() async {
    await _getMyPos();

    context.bloc<MapMarksCubit>().populateMarkers();
  }

  @override
  void initState() {
    initStateAsync();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mapa de Devs',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<MyPositionCubit, Position>(
        builder: (_, position) {
          if (position == null)
            return Center(child: CircularProgressIndicator());
          else
            return Stack(
              children: <Widget>[
                googleMap(context),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      searchField(context, position: position),
                      searchFloatingButton(context, position: position),
                    ],
                  ),
                ),
              ],
            );
        },
      ),
    );
  }

  Widget googleMap(BuildContext context) {
    // return BlocBuilder<KGooglePlexCubit, CameraPosition>(
    //   builder: (_, _kGooglePlex) {
    return BlocBuilder<MapMarksCubit, Map<String, Marker>>(builder: (_, mapMarkers) {
      print(mapMarkers);
      return GoogleMap(
        mapType: MapType.normal,
        zoomGesturesEnabled: true,
        myLocationButtonEnabled: false,
        myLocationEnabled: true,
        buildingsEnabled: true,
        zoomControlsEnabled: false,
        onTap: (_) => _goToMyPos(),
        markers: mapMarkers.values.toSet(),
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      );
    });
    //   },
    // );
  }

  Widget searchField(BuildContext context, {@required Position position}) {
    final phoneW = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: phoneW * 0.04),
      child: Container(
        height: 50,
        width: phoneW * 0.7,
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: 15, right: 15, left: 15),
            child: TextField(
              controller: _textController,
              showCursor: true,
              cursorColor: Colors.deepPurple,
              style: TextStyle(decoration: TextDecoration.none),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 9),
                  border: InputBorder.none,
                  hintStyle:
                      TextStyle(fontSize: 13, color: Colors.grey, fontStyle: FontStyle.italic),
                  hintText: 'Buscar por tecnologias...'),
              onSubmitted: (value) async {
                if (_textController.text != '' || _textController.text != null) {
                  context.bloc<MapMarksCubit>().state.clear();

                  await context.bloc<MapMarksCubit>().filterMarkers(
                      _textController.text.toLowerCase(), position.latitude, position.longitude);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget searchFloatingButton(BuildContext context, {@required Position position}) {
    final mapMarks = context.bloc<MapMarksCubit>();

    return Padding(
      padding: EdgeInsets.only(right: 20.0, bottom: 20),
      child: FloatingActionButton(
        elevation: 6.0,
        child: Icon(Icons.gps_fixed),
        onPressed: () async {
          mapMarks.state.clear();

          _textController.text == '' || _textController.text == null
              ? await mapMarks.populateMarkers()
              : await mapMarks.filterMarkers(
                  _textController.text.toLowerCase(), position.latitude, position.longitude);
        },
      ),
    );
  }
}
