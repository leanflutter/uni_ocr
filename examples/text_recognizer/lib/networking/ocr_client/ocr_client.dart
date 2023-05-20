import 'package:uni_ocr/uni_ocr.dart';

const kBuiltInOcrEngine = 'built_in_ocr_engine';

final kDefaultBuiltInOcrEngine = BuiltInOcrEngine(
  identifier: kBuiltInOcrEngine,
  option: {},
);

bool kDefaultBuiltInOcrEngineIsSupportedOnCurrentPlatform = false;

const kSupportedOcrEngineTypes = [
  kOcrEngineTypeYoudao,
];

class AutoloadOcrClientAdapter extends UniOcrClientAdapter {
  final Map<String, OcrEngine> _ocrEngineMap = {};

  @override
  OcrEngine get first {
    return use(kBuiltInOcrEngine);
  }

  @override
  OcrEngine use(String identifier) {
    if (identifier != kBuiltInOcrEngine) {
      throw UnsupportedError('$identifier ocr engine');
    }
    return kDefaultBuiltInOcrEngine;
  }

  void renew(String identifier) {
    _ocrEngineMap.remove(identifier);
  }
}

UniOcrClient ocrClient = UniOcrClient(AutoloadOcrClientAdapter());
