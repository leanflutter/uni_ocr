import 'package:ocr_engine_youdao/ocr_engine_youdao.dart';
import 'package:uni_ocr_client/uni_ocr_client.dart';

import '../../includes.dart';

UniOcrClient? ocrClient;

Future<void> initOcrClient() async {
  if (ocrClient == null) {
    List<OcrEngine> ocrEngines = [];
    for (var engineConfig in sharedConfig.ocrEngines) {
      OcrEngine? ocrEngine;

      switch (engineConfig.type) {
        case kOcrEngineTypeYoudao:
          ocrEngine = YoudaoOcrEngine(engineConfig);
          break;
      }
      if (ocrEngine != null) {
        ocrEngines.add(ocrEngine);
      }
    }

    ocrClient = UniOcrClient(
      DefaultUniOcrClientAdapter(ocrEngines),
    );
  }
}
