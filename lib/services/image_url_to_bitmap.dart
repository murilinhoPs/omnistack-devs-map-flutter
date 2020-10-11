import 'dart:typed_data';
import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:oministack_flutter_app/models/dev_model.dart';

class ImageUrlToBitmap {
  Future<BitmapDescriptor> avatarUrlToBitmap(DevProfile data) async {
    final avatarRes = await get(data.avatarUrl);

    final imageCodec = await instantiateImageCodec(avatarRes.bodyBytes, targetWidth: 80);

    final FrameInfo frameInfo = await imageCodec.getNextFrame();

    final ByteData byteData = await frameInfo.image.toByteData(format: ImageByteFormat.png);

    final resizedImage = byteData.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(resizedImage);
  }
}
