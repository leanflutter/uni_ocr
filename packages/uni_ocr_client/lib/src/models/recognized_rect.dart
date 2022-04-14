class RecognizedRect {
  /// x 坐标。
  num x;

  /// y 坐标。
  num y;

  /// 宽度。
  num width;

  /// 高度。
  num height;

  /// 顶坐标值（与 y 具有相同的值，如果 height 为负值，则为 y + height 的值）。
  num? top;

  /// 右坐标值（与 x + width 具有相同的值，如果width 为负值，则为 x 的值）。
  num? right;

  /// 底坐标值（与 y + height 具有相同的值，如果 height 为负值，则为 y 的值）。
  num? bottom;

  /// 左坐标值（与 x 具有相同的值，如果 width 为负值，则为 x + width 的值）。
  num? left;

  RecognizedRect({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  factory RecognizedRect.fromJson(Map<String, dynamic> json) {
    return RecognizedRect(
      x: json['x'],
      y: json['y'],
      width: json['width'],
      height: json['height'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
      'width': width,
      'height': height,
    }..removeWhere((key, value) => value == null);
  }
}
