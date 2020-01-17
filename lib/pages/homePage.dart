import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oministack_flutter_app/services/http_response.dart';

import 'webViewPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiConnection _apiConnection = ApiConnection();

  Position minhaPosicao;

  CameraPosition _kGooglePlex;

  Map<String, Marker> _markers = {};

  Completer<GoogleMapController> _controller = Completer();

  Geolocator _geolocator = Geolocator();

  _goToMyPos() async {
    //await _getMyPos();
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));
  }

  _getMyPos() async {
    await _geolocator.checkGeolocationPermissionStatus();
    var currentLocation = await _geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    setState(() {
      minhaPosicao = currentLocation;
      _kGooglePlex = CameraPosition(
        target: LatLng(minhaPosicao.latitude, minhaPosicao.longitude),
        zoom: 16.0,
      );

      print(_kGooglePlex);
    });
  }

  _populateMarkers() async {
    final apiRes = await _apiConnection.fetchDevs();
    setState(() {
      _markers.clear();

      for (var data in apiRes) {
        final m = Marker(
          markerId: MarkerId(data.sId),
          position: LatLng(
            data.location.coordinates[1],
            data.location.coordinates[0],
          ),
          infoWindow: InfoWindow(
              title: data.name,
              snippet: '${data.techs.join(', ')}',
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => Perfil(
                          url: 'https://github.com/${data.githubUsername}')),
                );
              }),
        );
        _markers[data.sId] = m;
      }
    });
  }

  _filterMarkers(techs, lat, lon) async {
    final apiRes = await _apiConnection.filterDevs(techs, lat, lon);
    setState(() {
      _markers.clear();

      for (var data in apiRes) {
        final m = Marker(
          markerId: MarkerId(data.sId),
          position: LatLng(
            data.location.coordinates[1],
            data.location.coordinates[0],
          ),
          infoWindow: InfoWindow(
              title: data.name,
              snippet: '${data.techs.join(', ')}',
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => Perfil(
                          url: 'https://github.com/${data.githubUsername}')),
                );
              }),
        );
        _markers[data.sId] = m;
      }
    });
  }

  @override
  void initState() {
    _getMyPos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final phoneW = MediaQuery.of(context).size.width;
    //final phoneH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mapa de Devs',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: minhaPosicao == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: <Widget>[
                GoogleMap(
                  mapType: MapType.normal,
                  zoomGesturesEnabled: true,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                  buildingsEnabled: true,
                  onTap: (_) async {
                    //print(_.latitude + _.longitude);
                    await _goToMyPos();
                    //_apiConnection.filterDevs();
                  },
                  markers: _markers.values.toSet(),
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: phoneW * 0.04),
                        child: Container(
                          height: 50,
                          width: phoneW * 0.7,
                          child: Card(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom: 15, right: 15, left: 15),
                              child: TextField(
                                showCursor: true,
                                cursorColor: Colors.deepPurple,
                                style:
                                    TextStyle(decoration: TextDecoration.none),
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 9),
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey,
                                        fontStyle: FontStyle.italic),
                                    hintText: 'Buscar por tecnologias...'),
                                onSubmitted: (value) {
                                  _filterMarkers(
                                      value,
                                      // value.replaceFirst(
                                      //     value[0], value[0].toUpperCase()),
                                      minhaPosicao.latitude,
                                      minhaPosicao.longitude);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20.0, bottom: 20),
                        child: FloatingActionButton(
                          elevation: 6.0,
                          child: Icon(Icons.gps_fixed),
                          onPressed: () async {
                            await _apiConnection.fetchDevs();
                            _populateMarkers();
                            //TODO: Adicionar controller no text field. Se tiver coisa escrita
                            // chama o metodo _filter, se não tiver nada chama o _populate
                            // _filterMarkers(null, null, null);
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
