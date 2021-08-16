import 'dart:convert';
import 'dart:io';

class DetectTextRequest {
  final String imagePath;

  String _base64Image;

  String getBase64Image() {
    if (_base64Image == null) {
      File imageFile = File(imagePath);
      List<int> imageBytes = imageFile.readAsBytesSync();
      _base64Image = base64Encode(imageBytes);
    }
    return _base64Image;
  }

  DetectTextRequest({
    this.imagePath,
    String base64Image,
  }) {
    if (base64Image != null) {
      this._base64Image = base64Image;
    }
  }

  factory DetectTextRequest.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return DetectTextRequest(
      imagePath: json['imagePath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
    };
  }
}
