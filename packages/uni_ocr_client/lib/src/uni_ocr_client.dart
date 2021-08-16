import 'ocr_engine.dart';
import 'uni_ocr_client_adapter.dart';

class UniOcrClient {
  final UniOcrClientAdapter adapter;

  UniOcrClient(this.adapter);

  OcrEngine get firstEngine {
    return adapter.first;
  }

  OcrEngine use(String identifier) {
    return adapter.use(identifier);
  }
}
