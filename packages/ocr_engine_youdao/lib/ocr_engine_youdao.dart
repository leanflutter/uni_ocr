library ocr_engine_youdao;

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:uni_ocr_client/uni_ocr_client.dart';

const String kOcrEngineTypeYoudao = 'youdao';

const String _kEngineOptionKeyAppKey = 'appKey';
const String _kEngineOptionKeyAppSecret = 'appSecret';

String _md5(String data) {
  return md5.convert(utf8.encode(data)).toString();
}

String _sha256(String data) {
  return sha256.convert(utf8.encode(data)).toString();
}

class YoudaoOcrEngine extends OcrEngine {
  static List<String> optionKeys = [
    _kEngineOptionKeyAppKey,
    _kEngineOptionKeyAppSecret,
  ];

  YoudaoOcrEngine(OcrEngineConfig config) : super(config);

  String get type => kOcrEngineTypeYoudao;

  String get _optionAppKey => option[_kEngineOptionKeyAppKey];
  String get _optionAppSecret => option[_kEngineOptionKeyAppSecret];

  @override
  Future<DetectTextResponse> detectText(DetectTextRequest request) async {
    DetectTextResponse detectTextResponse = DetectTextResponse();

    String base64Image = request.getBase64Image();
    String input = base64Image;
    if (base64Image.length > 20)
      input =
          '${base64Image.substring(0, 10)}${base64Image.length}${base64Image.substring(base64Image.length - 10)}';

    final curtime = (DateTime.now().millisecondsSinceEpoch ~/ 1000);
    final salt = _md5("ocr_engine_youdao");
    final sign =
        _sha256('$_optionAppKey$input$salt${curtime}$_optionAppSecret');

    Uri uri = Uri.https('openapi.youdao.com', '/ocrapi');
    Map body = {
      'img': base64Image,
      'langType': 'auto',
      'detectType': '10012',
      'imageType': '1',
      'docType': '',
      'angle': '0',
      'column': 'onecolumn',
      'rotate': 'donot_rotate',
      'appKey': _optionAppKey,
      'salt': salt.toString(),
      'sign': sign.toString(),
      'signType': 'v3',
      'curtime': '$curtime',
    };

    var response = await http.post(uri, body: body);
    Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));

    if (data['Result'] != null) {
      var lines = data['Result']['regions'][0]['lines'];
      if (lines != null) {
        detectTextResponse.text =
            (lines as List).map((e) => e['text']).toList().join(' ');
      }
    }

    return detectTextResponse;
  }
}
