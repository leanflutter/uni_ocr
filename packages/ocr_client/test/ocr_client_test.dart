import 'package:test/test.dart';

import 'package:ocr_client/ocr_client.dart';

void main() {
  test('adds one to input values', () {
    final client = OcrClient(DefaultOcrClientAdapter([]));
    client.firstEngine.detectText(DetectTextRequest());
  });
}
