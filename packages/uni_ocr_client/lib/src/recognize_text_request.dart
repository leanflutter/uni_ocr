import 'dart:convert';
import 'dart:io';

class RecognizeTextRequest {
  RecognizeTextRequest({
    this.imagePath,
    String? base64Image,
  }) {
    if (base64Image != null) {
      _base64Image = base64Image;
    }
  }

  factory RecognizeTextRequest.fromJson(Map<String, dynamic> json) {
    return RecognizeTextRequest(
      imagePath: json['imagePath'],
    );
  }
  final String? imagePath;

  String? _base64Image;

  String getBase64Image() {
    if (_base64Image == null) {
      File imageFile = File(imagePath!);
      List<int> imageBytes = imageFile.readAsBytesSync();
      _base64Image = base64Encode(imageBytes);
    }
    return _base64Image!;
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
    };
  }
}
