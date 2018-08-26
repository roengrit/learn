import 'dart:async';
import 'dart:io';

Future main() async {

  HttpServer server = await HttpServer.bind(
    InternetAddress.anyIPv4,
    4041,
  );
  await for (var request in server) {
    try {
      if (request.method == 'GET') {
        final q = request.uri.queryParameters['q'];
        request.response
          ..writeln("Param is $q.")
          ..close();
      } else {
        request.response
          ..statusCode = HttpStatus.methodNotAllowed
          ..write('Unsupported request: ${request.method}.')
          ..close();
      }
    } catch (e) {
      print('Exception in handleRequest: $e');
    }
  }
}
