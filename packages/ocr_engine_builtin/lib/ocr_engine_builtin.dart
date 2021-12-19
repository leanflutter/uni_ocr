library ocr_engine_builtin;

import 'package:flutter/services.dart';
import 'package:uni_ocr_client/uni_ocr_client.dart';

const String kOcrEngineTypeBuiltIn = 'built_in';

class BuiltInOcrEngine extends OcrEngine {
  static const MethodChannel _channel = MethodChannel('ocr_engine_builtin');

  static List<String> optionKeys = [];

  BuiltInOcrEngine(OcrEngineConfig config) : super(config);

  @override
  String get type => kOcrEngineTypeBuiltIn;

  @override
  Future<bool> isSupportedOnCurrentPlatform() async {
    return await _channel.invokeMethod('isSupportedOnCurrentPlatform');
  }

  @override
  Future<DetectTextResponse> detectText(DetectTextRequest request) async {
    final Map<String, dynamic> arguments = {
      'base64Image': request.getBase64Image(),
    };
    final String? text = await _channel.invokeMethod(
      'detectText',
      arguments,
    );

    DetectTextResponse detectTextResponse = DetectTextResponse(
      text: text,
    );

    return detectTextResponse;
  }
}
