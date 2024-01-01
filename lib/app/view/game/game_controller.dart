import 'package:web_socket_channel/io.dart';

import '../world/world_controller.dart';

class GameController {

  GameController() {
    worldController = WorldController(this);
  }

  final channels = <IOWebSocketChannel>[];
  late final WorldController worldController;

  void handleNewConnection(IOWebSocketChannel channel) {
    channels.add(channel);
    channel.stream.listen((message) {
      worldController.handleGameEvent(message);
    });
  }

  void broadcastMessage(String message) {
    for (var channel in channels) {
      channel.sink.add(message);
    }
  }
}
