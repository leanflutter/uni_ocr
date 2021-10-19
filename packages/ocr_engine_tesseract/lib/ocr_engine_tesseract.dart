library translation_engine_tesseract;

import 'dart:io';

import 'package:uni_ocr_client/uni_ocr_client.dart';

const String kOcrEngineTypeTesseract = 'tesseract';

class TesseractOcrEngine extends OcrEngine {
  TesseractOcrEngine(OcrEngineConfig config) : super(config);

  String get type => kOcrEngineTypeTesseract;

  @override
  Future<DetectTextResponse> detectText(DetectTextRequest request) async {
    DetectTextResponse detectTextResponse = DetectTextResponse();
    String ocrOutputPath = request.imagePath.replaceAll(".png", ".txt");
    ProcessResult processResult = Process.runSync('tesseract', [
      request.imagePath,
      ocrOutputPath.replaceAll('.txt', ''),
    ]);
    if (processResult.exitCode == 0) {
      File file = File(ocrOutputPath);
      detectTextResponse.text = file.readAsStringSync();
    }
    return detectTextResponse;
  }
}
