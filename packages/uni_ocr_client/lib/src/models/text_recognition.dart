import 'recognized_rect.dart';

class TextRecognition {
  String text;
  RecognizedRect recognizedRect;

  TextRecognition({
    this.text,
    this.recognizedRect,
  });

  factory TextRecognition.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return TextRecognition(
      text: json['text'],
      recognizedRect: RecognizedRect.fromJson(
          Map<String, dynamic>.from(json['recognizedRect'])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'recognizedRect': recognizedRect.toJson(),
    };
  }
}
