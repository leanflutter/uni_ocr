import 'recognize_text_request.dart';
import 'recognize_text_response.dart';

abstract class OcrEngine {
  String get type => throw UnimplementedError();

  String identifier;
  Map<String, dynamic>? option;
  bool disabled = false;

  OcrEngine({
    required this.identifier,
    this.option,
  });

  Future<bool> isSupportedOnCurrentPlatform() => Future.value(true);

  Future<RecognizeTextResponse> recognizeText(RecognizeTextRequest request);

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'type': type,
      'disabled': disabled,
    };
  }
}
