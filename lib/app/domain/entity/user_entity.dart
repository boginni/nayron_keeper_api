class UserEntity {
  const UserEntity({
    required this.id,
    required this.login,
    required this.pass,
  });

  final String id;
  final String login;
  final String pass;

  Map<String, dynamic> geJwtPayload() {
    return {
      'userId': id,
    };
  }

  Object? toJson() {
    return {
      'login': login,
    };
  }
}
