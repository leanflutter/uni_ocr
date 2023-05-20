class UniOcrClientError implements Exception {
  UniOcrClientError({
    required this.code,
    required this.message,
  });

  final String code;
  final String message;

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    }..removeWhere((key, value) => value == null);
  }
}
