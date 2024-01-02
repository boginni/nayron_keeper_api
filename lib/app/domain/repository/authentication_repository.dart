import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:uuid/uuid.dart';

import '../entity/user_entity.dart';

final Map<String, UserEntity> _users = {};

final tokenBlackList = <String>{};

class AuthenticationRepository {
  const AuthenticationRepository({
    required this.generator,
    required this.jwtSecret,
  });

  final Uuid generator;
  final String jwtSecret;

  Future<UserEntity> getUserById(String id) async {
    try {
      return _users.values.firstWhere((element) => element.id == id);
    } catch (e) {
      throw Exception('User not found');
    }
  }

  Future<UserEntity> getUserByToken(String token) {
    if (tokenBlackList.contains(token)) {
      throw Exception('Token is blacklisted');
    }

    final jwt = JWT.verify(token, SecretKey(jwtSecret));
    final userId = jwt.payload['userId']?.toString();

    if (userId != null) {
      return getUserById(userId);
    } else {
      throw Exception('User not found');
    }
  }

  String _getJwtToken(UserEntity user) {
    final jwt = JWT(
      user.geJwtPayload(),
      // issuer: 'your_issuer',
      // subject: user.login,
    );

    return jwt.sign(SecretKey(jwtSecret));
  }

  Future<String> signIn({
    required String login,
    required String pass,
  }) async {
    final user = _users[login];

    if (user != null && user.pass == pass) {
      return _getJwtToken(user);
    } else {
      throw Exception('User not found');
    }
  }

  Future<String> signUpAsGuest() async {
    final user = UserEntity(
      id: generator.v4(),
      login: 'guest',
      pass: generator.v4(),
    );

    _users.putIfAbsent(user.id, () => user);

    return _getJwtToken(user);
  }

  Future<void> signOut(String token) async {
    tokenBlackList.add(token);
  }

  Future<String> signUp({
    required String login,
    required String pass,
  }) async {
    final user = UserEntity(
      id: generator.v4(),
      login: login,
      pass: pass,
    );

    _users.putIfAbsent(login, () => user);

    return _getJwtToken(user);
  }
}
