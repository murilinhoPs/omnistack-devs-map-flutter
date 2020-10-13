import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:oministack_flutter_app/models/dev_model.dart';
import 'package:oministack_flutter_app/pages/webViewPage.dart';

class PictureMark {
  Marker markToAdd({BitmapDescriptor renderIcon, DevProfile data}) {
    return Marker(
      icon: renderIcon,
      markerId: MarkerId(data.sId),
      position: LatLng(
        data.location.coordinates[1],
        data.location.coordinates[0],
      ),
      infoWindow: InfoWindow(
        title: data.name,
        snippet: '${data.techs.join(', ')}',
        onTap: () {
          Get.to(Perfil(url: 'https://github.com/${data.githubUsername}'),
              transition: Transition.cupertino);
          // navigator.push(
          //   CupertinoPageRoute(
          //       builder: (_) => Perfil(url: 'https://github.com/${data.githubUsername}')),
          // );
        },
      ),
    );
  }
}
