import './services/services.dart';
import './utils/utils.dart';

// 请按文件名排序放置
export './controllers/controllers.dart';
export './services/services.dart';
export './utils/utils.dart';

Future<void> init() async {
  await initConfig();
  await initOcrClient();
}
