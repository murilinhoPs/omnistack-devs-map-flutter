import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/state_manager.dart';
import 'package:oministack_flutter_app/cubit/k_google_plex_cubit.dart';
import 'package:oministack_flutter_app/cubit/map_marks_cubit.dart';
import 'package:oministack_flutter_app/cubit/my_position_cubit.dart';
import 'package:get/get.dart';
import 'package:oministack_flutter_app/widgets/api_state_widget.dart';
import 'package:oministack_flutter_app/widgets/google_map_view.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final positionController = Get.put(MyPositionCubit());

  final mapMarkersController = Get.put(MapMarksCubit());

  final kGoogleCamera = Get.put(KGooglePlexCubit());

  TextEditingController _textController = TextEditingController();

  initStateAsync() async {
    await kGoogleCamera.setKGooglePlexPos();

    mapMarkersController.populateMarkers();
  }

  @override
  void initState() {
    super.initState();
    initStateAsync();
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
      body: Stack(
        children: <Widget>[
          Mapa(),
          ApiStateWidget(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                searchField(context, position: positionController.currentPosition.value),
                searchFloatingButton(context, position: positionController.currentPosition.value),
              ],
            ),
          ),
        ],
      ),
    );
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
              onSubmitted: (value) {
                if (_textController.text != '' || _textController.text != null) {
                  Get.find<MapMarksCubit>().filterMarkers(
                      _textController.text.toLowerCase(), position.latitude, position.longitude);

                  _textController.clear();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget searchFloatingButton(BuildContext context, {@required Position position}) {
    final mapMarks = Get.find<MapMarksCubit>();

    return Padding(
      padding: EdgeInsets.only(right: 20.0, bottom: 20),
      child: FloatingActionButton(
        elevation: 6.0,
        child: Icon(Icons.gps_fixed),
        onPressed: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }

          _textController.text == '' || _textController.text == null
              ? mapMarks.populateMarkers()
              : mapMarks.filterMarkers(
                  _textController.text.toLowerCase(), position.latitude, position.longitude);
          _textController.clear();
        },
      ),
    );
  }
}
