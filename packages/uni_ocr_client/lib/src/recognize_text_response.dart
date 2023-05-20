import 'package:uni_ocr_client/src/models/text_recognition.dart';

class RecognizeTextResponse {
  RecognizeTextResponse({
    required this.text,
    this.recognitions,
  });

  factory RecognizeTextResponse.fromJson(Map<String, dynamic> json) {
    List<TextRecognition>? recognitions;

    if (json['recognitions'] != null) {
      Iterable l = json['recognitions'] as List;
      recognitions = l
          .map((item) =>
              TextRecognition.fromJson(Map<String, dynamic>.from(item)))
          .toList();
    }

    return RecognizeTextResponse(
      text: json['text'] ?? (recognitions ?? []).map((e) => e.text).join(' '),
      recognitions: recognitions,
    );
  }

  String text;
  List<TextRecognition>? recognitions;

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'recognitions': recognitions?.map((e) => e.toJson()).toList(),
    }..removeWhere((key, value) => value == null);
  }
}
