import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:uni_ocr_api/includes.dart';
import 'package:uni_ocr_client/uni_ocr_client.dart';

class OcrEngineController {
  DefaultUniOcrClientAdapter? get _adapter {
    return ocrClient?.adapter as DefaultUniOcrClientAdapter?;
  }

  Future<Response> getEngines(
    Request request,
  ) async {
    final data = (_adapter?.engines ?? []).map((e) => e.toJson()).toList();
    return JsonResponse.ok(data);
  }

  Future<Response> getEngine(
    Request request,
    String identifier,
  ) async {
    final data = ocrClient?.use(identifier).toJson();
    if (data == null) {
      return JsonResponse.notFound({});
    }
    return JsonResponse.ok(data);
  }

  Future<Response> recognizeText(
    Request request,
    String identifier,
  ) async {
    try {
      final payload = await request.readAsString();
      final body = json.decode(payload);
      String base64Image = body['base64Image'];

      final RecognizeTextResponse response =
          await ocrClient!.use(identifier).recognizeText(
                RecognizeTextRequest(
                  base64Image: base64Image,
                ),
              );
      return JsonResponse.ok(response.toJson());
    } catch (error) {
      if (error is UniOcrClientError) {
        return JsonResponse.internalServerError(
          body: error.toJson(),
        );
      }
      return JsonResponse.internalServerError(
        body: {'message': error.toString()},
      );
    }
  }

  Router get router {
    final router = Router();
    router.get('/', getEngines);
    router.get('/<identifier>', getEngine);
    router.get('/<identifier>/recognizeText', recognizeText);
    router.get('/<identifier>/detectText', recognizeText);
    return router;
  }
}
