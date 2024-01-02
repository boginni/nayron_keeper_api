import 'dart:io';

import 'package:nayron_keeper_api/app/domain/entity/auth_request_entity.dart';
import 'package:nayron_keeper_api/app/domain/repository/authentication_repository.dart';

abstract class IAuthController {
  Future<void> signIn(HttpRequest req);

  Future<void> signInAsGuest(HttpRequest req);

  Future<void> signUp(HttpRequest req);

  Future<void> signOut(HttpRequest req);
}

class AuthenticationController implements IAuthController {
  const AuthenticationController({
    required this.authRepository,
  });

  final AuthenticationRepository authRepository;

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
    final token = req.uri.queryParameters['token'];

    try {
      if (token == null) {
        throw Exception();
      }

      await authRepository.signOut(token);
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
