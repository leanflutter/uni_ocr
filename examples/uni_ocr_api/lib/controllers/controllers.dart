import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:uni_ocr_api/controllers/ocr_engine_controller.dart';
import 'package:uni_ocr_api/utils/utils.dart';

export './ocr_engine_controller.dart';

class RootController {
  final OcrEngineController _ocrEngineController = OcrEngineController();

  withMiddleware(Router router) {
    final middleware = createMiddleware(
      requestHandler: (request) {
        String? authKey = request.url.queryParameters['authKey'];
        if (sharedConfig.authEnabled && authKey != sharedConfig.authKey) {
          return JsonResponse(
            401,
            body: json.encode({'message': 'Unauthorized'}),
          );
        }
        return null;
      },
    );
    return Pipeline().addMiddleware(middleware).addHandler(router);
  }

  Handler get handler {
    final router = Router();

    router.mount('/ocr_engines', withMiddleware(_ocrEngineController.router));

    // You can catch all verbs and use a URL-parameter with a regular expression
    // that matches everything to catch app.
    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page not found');
    });

    return router;
  }
}
