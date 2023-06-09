import 'dart:convert';

import 'package:ocr_engine_builtin/ocr_engine_builtin_platform_interface.dart';
import 'package:uni_ocr_client/uni_ocr_client.dart' hide OcrEngine;
import 'package:windows_graphics/windows_graphics.dart';
import 'package:windows_media/windows_media.dart';
import 'package:windows_storage/windows_storage.dart';

class OcrEngineBuiltinPluginWindows extends OcrEngineBuiltinPlatform {
  /// Registers this class as the default instance of [OcrEngineBuiltinPlatform]
  static void registerWith() {
    OcrEngineBuiltinPlatform.instance = OcrEngineBuiltinPluginWindows();
  }

  @override
  Future<bool> isSupportedOnCurrentPlatform() {
    return Future.value(true);
  }

  @override
  Future<RecognizeTextResponse> recognizeText(
    RecognizeTextRequest request,
  ) async {
    try {
      final imageBytes = base64.decode(request.getBase64Image());
      final stream = InMemoryRandomAccessStream();
      DataWriter dataWriter = DataWriter.createDataWriter(stream);
      dataWriter.writeBytes(imageBytes);
      dataWriter.storeAsync();
      // Create a BitmapDecoder from the stream
      final decoder = await BitmapDecoder.createAsync(stream);
      if (decoder != null) {
        // Get the SoftwareBitmap representation of the file
        final softwareBitmap = await decoder.getSoftwareBitmapAsync();
        // Create an OcrEngine from the user's preferred languages
        final ocrEngine = OcrEngine.tryCreateFromUserProfileLanguages();
        if (ocrEngine != null) {
          // Recognize the text in the image
          final ocrResult = await ocrEngine.recognizeAsync(softwareBitmap);
          if (ocrResult != null) {
            return RecognizeTextResponse(text: ocrResult.text);
          }
        }
      }
    } catch (error) {
      rethrow;
    }
    throw UniOcrClientError(code: '-1', message: 'Unable to recognize text');
  }
}
