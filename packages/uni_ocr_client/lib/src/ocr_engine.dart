import 'recognize_text_request.dart';
import 'recognize_text_response.dart';

class OcrEngineConfig {
  final String identifier;
  String type;
  String name;
  Map<String, dynamic> option;
  bool disabled = false;

  String get shortId => identifier.substring(0, 4);

  OcrEngineConfig({
    required this.identifier,
    required this.type,
    required this.name,
    required this.option,
    this.disabled = false,
  });

  factory OcrEngineConfig.fromJson(Map<String, dynamic> json) {
    return OcrEngineConfig(
      identifier: json['identifier'],
      type: json['type'],
      name: json['name'],
      option: Map<String, dynamic>.from(json['option'] ?? {}),
      disabled: json['disabled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'type': type,
      'option': option,
      'disabled': disabled,
    };
  }
}

abstract class OcrEngine {
  OcrEngineConfig config;

  String get identifier => config.identifier;
  String get type => config.type;
  String get name => config.name;
  Map<String, dynamic> get option => config.option;
  bool get disabled => config.disabled;

  OcrEngine(this.config);

  Future<bool> isSupportedOnCurrentPlatform() => Future.value(true);

  Future<RecognizeTextResponse> recognizeText(RecognizeTextRequest request);

  Map<String, dynamic> toJson() {
    return {
      'identifier': config.identifier,
      'type': type,
      'name': config.name,
      'disabled': disabled,
    };
  }
}
