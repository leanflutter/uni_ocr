import 'package:uni_ocr_client/src/recognize_text_request.dart';
import 'package:uni_ocr_client/src/recognize_text_response.dart';

abstract class OcrEngine {
  OcrEngine({
    required this.identifier,
    this.option,
  });

  String get type => throw UnimplementedError();

  String identifier;
  Map<String, dynamic>? option;
  bool disabled = false;

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
