class AuthRequestEntity {

  const AuthRequestEntity({
    required this.login,
    required this.pass,
  });

  factory AuthRequestEntity.fromJson(dynamic json) {
    return AuthRequestEntity(
      login: json['login'] as String,
      pass: json['pass'] as String,
    );
  }

  final String login;
  final String pass;

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'pass': pass,
    };
  }
}

