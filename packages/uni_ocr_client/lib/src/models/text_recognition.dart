import 'package:uni_ocr_client/src/models/recognized_rect.dart';

class TextRecognition {
  TextRecognition({
    required this.text,
    this.recognizedRect,
  });

  factory TextRecognition.fromJson(Map<String, dynamic> json) {
    RecognizedRect? recognizedRect;
    if (json['RecognizedRect'] == null) {
      recognizedRect = RecognizedRect.fromJson(
        Map<String, dynamic>.from(json['recognizedRect']),
      );
    }

    return TextRecognition(
      text: json['text'],
      recognizedRect: recognizedRect,
    );
  }
  String text;
  RecognizedRect? recognizedRect;

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'recognizedRect': recognizedRect?.toJson(),
    };
  }
}
