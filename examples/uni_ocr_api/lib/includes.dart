import 'package:uni_ocr_api/services/services.dart';
import 'package:uni_ocr_api/utils/utils.dart';

// 请按文件名排序放置
export './controllers/controllers.dart';
export './services/services.dart';
export './utils/utils.dart';

Future<void> init() async {
  await initConfig();
  await initOcrClient();
}
