import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';

class JsonResponse extends Response {
  JsonResponse(
    int statusCode, {
    Object? body,
    Map<String, Object>? headers = const {
      HttpHeaders.contentTypeHeader: 'application/json',
    },
    Encoding? encoding,
    Map<String, Object>? context,
  }) : super(
          statusCode,
          body: body,
          headers: {
            HttpHeaders.contentTypeHeader: ContentType.json.toString(),
          },
          encoding: encoding,
          context: context,
        );

  JsonResponse.ok(
    Object? body, {
    Map<String, /* String | List<String> */ Object>? headers,
    Encoding? encoding,
    Map<String, Object>? context,
  }) : this(
          200,
          body: json.encode(body),
          headers: headers,
          encoding: encoding,
          context: context,
        );

  JsonResponse.notFound(
    Object? body, {
    Map<String, /* String | List<String> */ Object>? headers,
    Encoding? encoding,
    Map<String, Object>? context,
  }) : this(
          404,
          headers: headers,
          body: json.encode(body ?? {'message': 'Not Found'}),
          context: context,
          encoding: encoding,
        );

  JsonResponse.internalServerError({
    Object? body,
    Map<String, /* String | List<String> */ Object>? headers,
    Encoding? encoding,
    Map<String, Object>? context,
  }) : this(
          500,
          headers: headers,
          body: json.encode(body ?? {'message': 'Internal Server Error'}),
          context: context,
          encoding: encoding,
        );
}
