import 'dart:async';
import 'dart:io';
import 'dart:convert';

String _host = InternetAddress.anyIPv4.host;

Future main() async {
  var server = await HttpServer.bind(_host, 4049);
  await for (var req in server) {
    ContentType contentType = req.headers.contentType;
    HttpResponse response = req.response;

    if (req.method == 'POST' && contentType?.mimeType == 'application/json' /*1*/) {
      try {
        String content = await req.transform(utf8.decoder).join(); /*2*/
        Map json = jsonDecode(content); /*3*/
        req.response
            ..statusCode = HttpStatus.ok
            ..write('Wrote data for ${json['name']}.');
      } catch (e) {
        response
          ..statusCode = HttpStatus.internalServerError
          ..write("Exception during file I/O: $e.");
      }
    } else {
      response
        ..statusCode = HttpStatus.methodNotAllowed
        ..write("Unsupported request: ${req.method}.");
    }
    response.close();
  }
}