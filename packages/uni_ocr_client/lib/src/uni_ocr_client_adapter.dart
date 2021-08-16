import 'ocr_engine.dart';

class DefaultUniOcrClientAdapter extends UniOcrClientAdapter {
  final List<OcrEngine> engines;

  DefaultUniOcrClientAdapter(this.engines);

  OcrEngine get first {
    return engines.first;
  }

  OcrEngine use(String identifier) {
    return engines.firstWhere((e) => e.identifier == identifier);
  }
}

abstract class UniOcrClientAdapter {
  OcrEngine get first;
  OcrEngine use(String identifier);
}
