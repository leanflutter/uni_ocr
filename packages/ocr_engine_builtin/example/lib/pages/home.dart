import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preference_list/preference_list.dart';
import 'package:screen_capturer/screen_capturer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ocr_engine_builtin/ocr_engine_builtin.dart';
import 'package:uni_ocr_client/uni_ocr_client.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BuiltInOcrEngine _builtInOcrEngine =
      BuiltInOcrEngine(OcrEngineConfig());

  bool _isAccessAllowed = false;
  CapturedData _lastCapturedData;
  DetectTextResponse _detectTextResponse;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    _isAccessAllowed = await ScreenCapturer.instance.isAccessAllowed();

    setState(() {});
  }

  void _handleClickCapture() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String imageName =
        'Screenshot-${DateTime.now().millisecondsSinceEpoch}.png';
    String imagePath =
        '${directory.path}/screen_capturer_example/Screenshots/$imageName';
    _lastCapturedData = await ScreenCapturer.instance.capture(
      imagePath: imagePath,
      silent: true,
    );
    setState(() {});

    if (_lastCapturedData != null) {
      DetectTextRequest request = DetectTextRequest(
        imagePath: _lastCapturedData?.imagePath,
      );
      _detectTextResponse = await _builtInOcrEngine.detectText(request);
      setState(() {});
    } else {
      // ignore: avoid_print
      print('User canceled capture');
    }
  }

  Widget _buildBody(BuildContext context) {
    return PreferenceList(
      children: <Widget>[
        if (Platform.isMacOS)
          PreferenceListSection(
            children: [
              PreferenceListItem(
                title: const Text('isAccessAllowed'),
                accessoryView: Text('$_isAccessAllowed'),
                onTap: () async {
                  bool allowed =
                      await ScreenCapturer.instance.isAccessAllowed();
                  BotToast.showText(text: 'allowed: $allowed');
                  setState(() {
                    _isAccessAllowed = allowed;
                  });
                },
              ),
              PreferenceListItem(
                title: const Text('requestAccess'),
                onTap: () async {
                  await ScreenCapturer.instance.requestAccess();
                },
              ),
            ],
          ),
        PreferenceListSection(
          title: const Text('METHODS'),
          children: [
            PreferenceListItem(
              title: const Text('capture'),
              onTap: () {
                _handleClickCapture();
              },
            ),
          ],
        ),
        if (_detectTextResponse != null)
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              _detectTextResponse.text ?? '',
            ),
          ),
        if (_lastCapturedData != null && _lastCapturedData?.imagePath != null)
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: 400,
            height: 400,
            child: Image.file(
              File(_lastCapturedData.imagePath),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: _buildBody(context),
    );
  }
}
