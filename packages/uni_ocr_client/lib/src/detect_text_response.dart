class DetectTextResponse {
  String text;

  DetectTextResponse({
    this.text,
  });

  factory DetectTextResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    return DetectTextResponse(
      text: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    }..removeWhere((key, value) => value == null);
  }
}
