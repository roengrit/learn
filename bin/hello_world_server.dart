import 'dart:io' show HttpRequest, HttpServer, InternetAddress;
import 'dart:async';

Future main() async {
  var server = await HttpServer.bind( InternetAddress.anyIPv4,  4040, );
  // #enddocregion bind
  print('Listening on localhost:${server.port}');

  await for (HttpRequest request in server) {
    request.response ..write('Hello, world!') ..close();
  }
  // #enddocregion listen
}