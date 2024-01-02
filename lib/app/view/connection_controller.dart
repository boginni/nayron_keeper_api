import 'package:nayron_keeper_api/app/domain/repository/event_repository.dart';
import 'package:web_socket_channel/io.dart';

class ConnectionController {
  final channels = <IOWebSocketChannel>[];

  final Map<String, IOWebSocketChannel> users = {};

  final EventRepository eventRepository = EventRepository();

  void handleNewConnection(IOWebSocketChannel channel) {
    channels.add(channel);
  }

  void handleDisconnection(IOWebSocketChannel channel) {
    channels.remove(channel);
  }
}
