import 'package:ocr_engine_tesseract/ocr_engine_tesseract.dart';
import 'package:uni_ocr_client/uni_ocr_client.dart';

Future<void> main(List<String> args) async {
  DefaultUniOcrClientAdapter adapter = DefaultUniOcrClientAdapter([
    TesseractOcrEngine(OcrEngineConfig(
      identifier: 'tesseract',
      type: kOcrEngineTypeTesseract,
    )),
  ]);
  UniOcrClient ocrClient = UniOcrClient(adapter);

  DetectTextRequest detectTextRequest = DetectTextRequest(
    imagePath: '/Users/lijy91/biyiapp/Screenshots/Screenshot-1634114641569.png',
  );
  DetectTextResponse detectTextResponse =
      await ocrClient.firstEngine.detectText(
    detectTextRequest,
  );
  print(detectTextResponse.toJson());
}
