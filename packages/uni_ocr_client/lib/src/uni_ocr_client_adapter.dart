import 'package:uni_ocr_client/src/ocr_engine.dart';

class DefaultUniOcrClientAdapter extends UniOcrClientAdapter {
  DefaultUniOcrClientAdapter(this.engines);

  final List<OcrEngine> engines;

  @override
  OcrEngine get first {
    return engines.first;
  }

  @override
  OcrEngine use(String identifier) {
    return engines.firstWhere((e) => e.identifier == identifier);
  }
}

abstract class UniOcrClientAdapter {
  OcrEngine get first;
  OcrEngine use(String identifier);
}
