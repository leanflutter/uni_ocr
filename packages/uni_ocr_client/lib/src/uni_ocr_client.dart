import 'package:uni_ocr_client/src/ocr_engine.dart';
import 'package:uni_ocr_client/src/uni_ocr_client_adapter.dart';

class UniOcrClient {
  UniOcrClient(this.adapter);

  final UniOcrClientAdapter adapter;

  OcrEngine get firstEngine {
    return adapter.first;
  }

  OcrEngine use(String identifier) {
    return adapter.use(identifier);
  }
}
