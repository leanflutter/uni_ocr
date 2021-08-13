import 'ocr_engine.dart';

class DefaultOcrClientAdapter extends OcrClientAdapter {
  final List<OcrEngine> engines;

  DefaultOcrClientAdapter(this.engines);

  OcrEngine get first {
    return engines.first;
  }

  OcrEngine use(String identifier) {
    return engines.firstWhere((e) => e.identifier == identifier);
  }
}

abstract class OcrClientAdapter {
  OcrEngine get first;
  OcrEngine use(String identifier);
}
