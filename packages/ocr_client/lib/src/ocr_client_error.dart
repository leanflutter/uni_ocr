class OcrClientError implements Exception {
  final String code;
  final String message;

  OcrClientError({
    this.code,
    this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'code': this.code,
      'message': this.message,
    }..removeWhere((key, value) => value == null);
  }
}
