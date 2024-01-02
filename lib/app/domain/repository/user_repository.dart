import 'package:nayron_keeper_api/app/domain/entity/event/event_entity.dart';
import 'package:web_socket_channel/io.dart';

class UserRepository {
  UserRepository();

  final Map<String, IOWebSocketChannel> users = {};

  void sendEvent(String userId, EventEntity event) async {
    users[userId]?.sink.add(event.toJson());
  }

  void addUser(String userId, IOWebSocketChannel channel) {
    users.putIfAbsent(userId, () => channel);
  }

  void removeUser(String userId) {
    users.remove(userId);
  }

  void broadcastEvent(EventEntity event) async {
    for (var channel in users.values) {
      channel.sink.add(event.toJson());
    }
  }
}
