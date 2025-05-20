// Base Models

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.g.dart';
part 'auth.freezed.dart';

@freezed
class AuthenticatedUser with _$AuthenticatedUser {
  factory AuthenticatedUser(
    String token,
    User user,
  ) = _AuthenticatedUser;

  factory AuthenticatedUser.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatedUserFromJson(json);
}

@freezed
class User with _$User {
  factory User(
    String email,
    String name,
    String uuid,
  ) = _User;
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
