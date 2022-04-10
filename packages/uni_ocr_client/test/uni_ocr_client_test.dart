import 'package:test/test.dart';

import 'package:uni_ocr_client/uni_ocr_client.dart';

void main() {
  test('adds one to input values', () {
    final client = UniOcrClient(DefaultUniOcrClientAdapter([]));
    client.firstEngine.recognizeText(RecognizeTextRequest());
  });
}
