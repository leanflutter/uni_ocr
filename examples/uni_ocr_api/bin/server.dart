import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;

import 'package:uni_ocr_api/includes.dart';

void main(List<String> args) async {
  await init();

  String address = '0.0.0.0';
  int port = 8080;

  Handler handler = RootController().handler;

  final server = await shelf_io.serve(handler, address, port);
  print('Server running on $address:${server.port}');
}
