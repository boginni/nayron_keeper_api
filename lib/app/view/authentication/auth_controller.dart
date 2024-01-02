import 'dart:io';

import 'package:nayron_keeper_api/app/domain/repository/authentication_repository.dart';

abstract class IAuthController {
  Future<void> signIn(HttpRequest req);

  Future<void> signUp(HttpRequest req);

  Future<void> signOut(HttpRequest req);
}

class AuthenticationController implements IAuthController {
  AuthenticationController({
    required this.authRepository,
  });

  final AuthenticationRepository authRepository;

  @override
  Future<void> signIn(HttpRequest req) async {
    final login = req.uri.queryParameters['login'];
    final pass = req.uri.queryParameters['pass'];

    if (login == null || pass == null) {
      final response = req.response;
      response.statusCode = HttpStatus.badRequest;

      return await response.close();
    }

    try {
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
      response.statusCode = HttpStatus.unauthorized;
      response.write(e);

      await response.close();
    }
  }

  @override
  Future<void> signOut(HttpRequest req) {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(HttpRequest req) async {
    final login = req.uri.queryParameters['login'];
    final pass = req.uri.queryParameters['pass'];

    if (login == null || pass == null) {
      final response = req.response;
      response.statusCode = HttpStatus.badRequest;

      return await response.close();
    }

    try {
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
      response.statusCode = HttpStatus.unauthorized;
      response.write(e);

      await response.close();
    }
  }
}
