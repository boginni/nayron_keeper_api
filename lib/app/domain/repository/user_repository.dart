import 'package:nayron_keeper_api/app/domain/entity/event/event_entity.dart';
import 'package:nayron_keeper_api/app/domain/entity/user_entity.dart';
import 'package:nayron_keeper_api/app/domain/repository/authentication_repository.dart';
import 'package:web_socket_channel/io.dart';

class UserRepository {
  UserRepository({required this.users});

  final Map<String, IOWebSocketChannel> users;

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
