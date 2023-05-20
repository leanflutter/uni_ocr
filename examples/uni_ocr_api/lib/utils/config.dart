import 'dart:io';
import 'package:yaml/yaml.dart';

class OcrEngineConfig {
  OcrEngineConfig({
    this.position = -1,
    this.group,
    required this.identifier,
    required this.type,
    required this.option,
    this.disabled = false,
  });

  factory OcrEngineConfig.fromJson(Map<dynamic, dynamic> json) {
    return OcrEngineConfig(
      position: json['position'] ?? -1,
      group: json['group'],
      identifier: json['identifier'],
      type: json['type'],
      option: Map<String, dynamic>.from(json['option'] ?? {}),
      disabled: json['disabled'] ?? false,
    );
  }

  int position;
  String? group;
  final String identifier;
  String type;
  Map<String, dynamic> option;
  bool disabled = false;

  Map<String, dynamic> toJson() {
    return {
      'position': position,
      'group': group,
      'identifier': identifier,
      'type': type,
      'option': option,
      'disabled': disabled,
    };
  }
}

Future<void> initConfig() async {
  final String jsonString = File('config.yaml').readAsStringSync();
  final YamlMap json = loadYaml(jsonString);
  Config.getInstance().parse(json);
}

class Config {
  Config._internal();
  static Config? _instance;

  static Config getInstance() {
    _instance ??= Config._internal();
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
  }

  late String env;
  late String authKey;
  late bool authEnabled;
  List<OcrEngineConfig> ocrEngines = [];
}
