import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:preference_list/preference_list.dart';
import 'package:screen_capturer/screen_capturer.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uni_ocr/uni_ocr.dart';

import '../networking/networking.dart';

final screenCapturer = ScreenCapturer.instance;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isAccessAllowed = false;

  CapturedData? _lastCapturedData;
  RecognizeTextResponse? _recognizeTextResponse;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    _isAccessAllowed = await screenCapturer.isAccessAllowed();

    setState(() {});
  }

  void _handleClickCapture(CaptureMode mode) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String imageName =
        'Screenshot-${DateTime.now().millisecondsSinceEpoch}.png';
    String imagePath =
        '${directory.path}/text_recognizer/Screenshots/$imageName';
    _lastCapturedData = await screenCapturer.capture(
      mode: mode,
      imagePath: imagePath,
      silent: true,
    );
    if (_lastCapturedData != null) {
      // ignore: avoid_print
      // print(_lastCapturedData!.toJson());
      _recognizeTextResponse = await ocrClient
          .use(kBuiltInOcrEngine)
          .recognizeText(RecognizeTextRequest(
            imagePath: imagePath,
          ));
    } else {
      // ignore: avoid_print
      print('User canceled capture');
    }
    setState(() {});
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
              accessoryView: Row(children: [
                CupertinoButton(
                  child: const Text('region'),
                  onPressed: () {
                    _handleClickCapture(CaptureMode.region);
                  },
                ),
                CupertinoButton(
                  child: const Text('screen'),
                  onPressed: () {
                    _handleClickCapture(CaptureMode.screen);
                  },
                ),
                CupertinoButton(
                  child: const Text('window'),
                  onPressed: () {
                    _handleClickCapture(CaptureMode.window);
                  },
                ),
              ]),
            ),
          ],
        ),
        if (_recognizeTextResponse != null)
          Text(_recognizeTextResponse?.text ?? ''),
        if (_lastCapturedData != null && _lastCapturedData?.imagePath != null)
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: 400,
            height: 400,
            child: Image.file(
              File(_lastCapturedData!.imagePath!),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('text_recognizer'),
      ),
      body: _buildBody(context),
    );
  }
}
