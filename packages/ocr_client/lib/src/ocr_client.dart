import 'ocr_engine.dart';
import 'ocr_client_adapter.dart';

class OcrClient {
  final OcrClientAdapter adapter;

  OcrClient(this.adapter);

  OcrEngine get firstEngine {
    return adapter.first;
  }

  OcrEngine use(String identifier) {
    return adapter.use(identifier);
  }
}
