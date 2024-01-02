import 'package:uuid/uuid.dart';

import '../entity/user_entity.dart';

class AuthenticationRepository {
  final generator = const Uuid();
  static final Map<String, UserEntity> users = {};

  Future<UserEntity> getUserById(String id) {
    final user = users[id];

    if (user != null) {
      return Future.value(user);
    } else {
      throw Exception('User not found');
    }
  }

  Future<String> signInWithPassword({
    required String login,
    required String pass,
  }) {
    final user = users[login];

    if (user != null && user.pass == pass) {
      return Future.value(user.id);
    } else {
      throw Exception('User not found');
    }
  }

  Future<String> signUp({
    required String login,
    required String pass,
  }) {
    if (users.containsValue(login)) {
      throw Exception('User already exists');
    } else {
      final id = generator.v4();
      final user = UserEntity(
        id: id,
        login: login,
        pass: pass,
      );
      users.putIfAbsent(id, () => user);
      return Future.value(id);
    }
  }
}
