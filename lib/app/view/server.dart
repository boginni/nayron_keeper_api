import 'dart:io';

import 'package:nayron_keeper_api/app/view/router.dart';

HttpServer? _server;

class Server {
  const Server({
    required this.router,
  });

  final Router router;

  void start() async {
    final server = await HttpServer.bind('127.0.0.1', 4040);

    _server = server;

    print('Listening on localhost:${server.port}');

    await for (HttpRequest req in server) {
      await router.handleNewConnection(req);
    }
  }

  void stop() {
    _server?.close(force: true);
    _server = null;
  }
}
