import 'models/detect_text_request.dart';
import 'models/detect_text_response.dart';

class OcrEngineConfig {
  final String identifier;
  String type;
  String name;
  Map<String, dynamic> option;
  bool disabled = false;

  String get shortId => identifier.substring(0, 4);

  OcrEngineConfig({
    this.identifier,
    this.type,
    this.name,
    this.option,
    this.disabled = false,
  });

  factory OcrEngineConfig.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return OcrEngineConfig(
      identifier: json['identifier'],
      type: json['type'],
      name: json['name'],
      option: json['option'] != null
          ? Map<String, dynamic>.from(json['option'])
          : null,
      disabled: json['disabled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'identifier': identifier,
      'type': type,
      'option': option,
      'disabled': disabled ?? false,
    };
  }
}

abstract class OcrEngine {
  OcrEngineConfig config;

  String get identifier => config.identifier;
  String get type => config.type;
  String get name => config.name;
  Map<String, dynamic> get option => config.option;
  bool get disabled => config.disabled ?? false;

  OcrEngine(this.config);

  Future<DetectTextResponse> detectText(DetectTextRequest request);

  Map<String, dynamic> toJson() {
    return {
      'identifier': config.identifier,
      'type': type,
      'name': config.name,
      'disabled': disabled,
    };
  }
}
