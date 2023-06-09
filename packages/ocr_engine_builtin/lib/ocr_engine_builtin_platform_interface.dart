import 'package:ocr_engine_builtin/ocr_engine_builtin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:uni_ocr_client/uni_ocr_client.dart';

abstract class OcrEngineBuiltinPlatform extends PlatformInterface {
  /// Constructs a OcrEngineBuiltinPlatform.
  OcrEngineBuiltinPlatform() : super(token: _token);

  static final Object _token = Object();

  static OcrEngineBuiltinPlatform _instance = MethodChannelOcrEngineBuiltin();

  /// The default instance of [OcrEngineBuiltinPlatform] to use.
  ///
  /// Defaults to [MethodChannelOcrEngineBuiltin].
  static OcrEngineBuiltinPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [OcrEngineBuiltinPlatform] when
  /// they register themselves.
  static set instance(OcrEngineBuiltinPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool> isSupportedOnCurrentPlatform() {
    throw UnimplementedError(
        'isSupportedOnCurrentPlatform() has not been implemented.');
  }

  Future<RecognizeTextResponse> recognizeText(RecognizeTextRequest request) {
    throw UnimplementedError('recognizeText() has not been implemented.');
  }
}
