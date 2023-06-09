import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:ocr_engine_builtin/ocr_engine_builtin_platform_interface.dart';
import 'package:uni_ocr_client/uni_ocr_client.dart';

/// An implementation of [OcrEngineBuiltinPlatform] that uses method channels.
class MethodChannelOcrEngineBuiltin extends OcrEngineBuiltinPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('ocr_engine_builtin');

  @override
  Future<bool> isSupportedOnCurrentPlatform() async {
    return await methodChannel.invokeMethod('isSupportedOnCurrentPlatform');
  }

  @override
  Future<RecognizeTextResponse> recognizeText(
      RecognizeTextRequest request) async {
    final Map<String, dynamic> arguments = {
      'base64Image': request.getBase64Image(),
    };
    final Map<dynamic, dynamic> resultData = await methodChannel.invokeMethod(
      'recognizeText',
      arguments,
    );

    return RecognizeTextResponse.fromJson(
      Map<String, dynamic>.from(resultData),
    );
  }
}
