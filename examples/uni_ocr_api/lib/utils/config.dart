import 'dart:io';
import 'package:uni_ocr_client/uni_ocr_client.dart';
import 'package:uni_translate_client/uni_translate_client.dart';
import 'package:yaml/yaml.dart';

Future<void> initConfig() async {
  final String jsonString = File('config.yaml').readAsStringSync();
  final YamlMap json = loadYaml(jsonString);
  Config.getInstance().parse(json);
}

class Config {
  static Config? _instance;
  Config._internal();

  static Config getInstance() {
    if (_instance == null) {
      _instance = Config._internal();
    }
    return _instance!;
  }

  void parse(YamlMap json) {
    env = json['env'] as String;
    authKey = json['authKey'] as String;
    authEnabled = json['authEnabled'] as bool;
    if (json['ocrEngines'] != null) {
      Iterable l = json['ocrEngines'] as List;
      ocrEngines = l.map((item) {
        Map<String, dynamic> j = Map<String, dynamic>.from(item);
        return OcrEngineConfig.fromJson(j);
      }).toList();
    }
    if (json['translationEngines'] != null) {
      Iterable l = json['translationEngines'] as List;
      translationEngines = l.map((item) {
        Map<String, dynamic> j = Map<String, dynamic>.from(item);
        return TranslationEngineConfig.fromJson(j);
      }).toList();
    }
  }

  late String env;
  late String authKey;
  late bool authEnabled;
  List<OcrEngineConfig> ocrEngines = [];
  List<TranslationEngineConfig> translationEngines = [];
}
