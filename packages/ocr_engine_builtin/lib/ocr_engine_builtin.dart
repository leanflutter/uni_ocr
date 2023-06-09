library ocr_engine_builtin;

import 'package:ocr_engine_builtin/ocr_engine_builtin_platform_interface.dart';
import 'package:uni_ocr_client/uni_ocr_client.dart';

const String kOcrEngineTypeBuiltIn = 'built_in';

class BuiltInOcrEngine extends OcrEngine {
  BuiltInOcrEngine({
    required String identifier,
    Map<String, dynamic>? option,
  }) : super(identifier: identifier, option: option);

  static List<String> optionKeys = [];

  @override
  String get type => kOcrEngineTypeBuiltIn;

  @override
  Future<bool> isSupportedOnCurrentPlatform() {
    return OcrEngineBuiltinPlatform.instance.isSupportedOnCurrentPlatform();
  }

  @override
  Future<RecognizeTextResponse> recognizeText(RecognizeTextRequest request) {
    return OcrEngineBuiltinPlatform.instance.recognizeText(request);
  }
}
