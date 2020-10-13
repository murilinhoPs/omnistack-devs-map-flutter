// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:oministack_flutter_app/models/dev_model.dart';
import 'package:oministack_flutter_app/services/http_response.dart';

void main() {
  test("Testing api connection and response", () async {
    final apiResponse = ApiConnection();

    var response = await apiResponse.fetchDevs();

    print(response);

    List<DevProfile> lista = [DevProfile(), DevProfile(), DevProfile(), DevProfile()];

    expect(response, lista);
  });
}
