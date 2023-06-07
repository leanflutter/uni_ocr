library ocr_engine_builtin;

import 'package:flutter/services.dart';
import 'package:uni_ocr_client/uni_ocr_client.dart';

const String kOcrEngineTypeBuiltIn = 'built_in';

class BuiltInOcrEngine extends OcrEngine {
  BuiltInOcrEngine({
    required String identifier,
    Map<String, dynamic>? option,
  }) : super(identifier: identifier, option: option);

  static const MethodChannel _channel = MethodChannel('ocr_engine_builtin');

  static List<String> optionKeys = [];

  @override
  String get type => kOcrEngineTypeBuiltIn;

  @override
  Future<bool> isSupportedOnCurrentPlatform() async {
    return await _channel.invokeMethod('isSupportedOnCurrentPlatform');
  }

  @override
  Future<RecognizeTextResponse> recognizeText(
      RecognizeTextRequest request) async {
    final Map<String, dynamic> arguments = {
      'base64Image': request.getBase64Image(),
    };
    final Map<dynamic, dynamic> resultData = await _channel.invokeMethod(
      'recognizeText',
      arguments,
    );

    RecognizeTextResponse recognizeTextResponse =
        RecognizeTextResponse.fromJson(Map<String, dynamic>.from(resultData));

    return recognizeTextResponse;
  }
}
