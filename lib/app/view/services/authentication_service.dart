import 'dart:io';

import 'package:nayron_keeper_api/app/domain/entity/auth_request_entity.dart';
import 'package:nayron_keeper_api/app/domain/repository/authentication_repository.dart';

abstract class IAuthenticationService {
  Future<void> signIn(HttpRequest req);

  Future<void> signInAsGuest(HttpRequest req);

  Future<void> signUp(HttpRequest req);

  Future<void> signOut(HttpRequest req);
}

class AuthenticationService implements IAuthenticationService {
  const AuthenticationService({
    required this.authRepository,
  });

  final AuthenticationRepository authRepository;

  String getAuthorizationToken(HttpRequest req) {
    return req.headers['Authorization'].toString().split(' ')[1];
  }

  @override
  Future<void> signIn(HttpRequest req) async {
    try {
      final authEntity = AuthRequestEntity.fromJson(req.uri.queryParameters);

      final login = authEntity.login;
      final pass = authEntity.pass;

      final token = await authRepository.signIn(
        login: login,
        pass: pass,
      );

      final response = req.response;
      response.statusCode = HttpStatus.ok;
      response.write(token);

      await response.close();
    } catch (e) {
      final response = req.response;
      response.statusCode = HttpStatus.badRequest;

      return await response.close();
    }
  }

  @override
  Future<void> signInAsGuest(HttpRequest req) async {
    try {
      final token = await authRepository.signUpAsGuest();

      final response = req.response;
      response.statusCode = HttpStatus.ok;
      response.write(token);

      await response.close();
    } catch (e) {
      final response = req.response;
      response.statusCode = HttpStatus.badRequest;

      return await response.close();
    }
  }

  @override
  Future<void> signOut(HttpRequest req) async {
    try {
      final token = getAuthorizationToken(req);

      await authRepository.signOut(token);
    } catch (e) {
      final response = req.response;
      response.statusCode = HttpStatus.badRequest;

      return response.close();
    }
  }

  Future<void> getCurrentUser(HttpRequest req) async {
    try {
      final token = getAuthorizationToken(req);

      final user = await authRepository.getUserByToken(token);

      final response = req.response;
      response.statusCode = HttpStatus.ok;
      response.write(user.toJson());

      await response.close();
    } catch (e) {
      final response = req.response;
      response.statusCode = HttpStatus.badRequest;

      return response.close();
    }
  }

  @override
  Future<void> signUp(HttpRequest req) async {
    try {
      final authEntity = AuthRequestEntity.fromJson(req.uri.queryParameters);

      final login = authEntity.login;
      final pass = authEntity.pass;

      final token = await authRepository.signUp(
        login: login,
        pass: pass,
      );

      final response = req.response;
      response.statusCode = HttpStatus.ok;
      response.write(token);

      await response.close();
    } catch (e) {
      final response = req.response;
      response.statusCode = HttpStatus.badRequest;

      return await response.close();
    }
  }
}
