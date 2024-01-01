import 'dart:io';

import 'package:web_socket_channel/io.dart';

import 'game/game_controller.dart';


class GameSocket {
  start() async {
    final server = await HttpServer.bind('127.0.0.1', 4040);

    print('Listening on localhost:${server.port}');

    final gameController = GameController();

    await for (HttpRequest req in server) {
      final socket = await WebSocketTransformer.upgrade(req);
      final channel = IOWebSocketChannel(socket);
      gameController.handleNewConnection(channel);
    }
  }
}
