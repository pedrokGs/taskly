import 'package:firebase_auth/firebase_auth.dart';
import 'package:taskly/features/auth/domain/entities/auth_user_entity.dart';
import 'package:taskly/features/auth/domain/exceptions/user_is_null_exception.dart';

class AuthUserModel {
  final String uid;
  final String email;

  const AuthUserModel({
    required this.uid,
    required this.email,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) {
    return AuthUserModel(
      uid: json["uid"] ?? "",
      email: json["email"] ?? "",
    );
  }

  // Retorna uma instância de AuthUserModel feita por uma UserCredential, útil para login, registro, etc
  factory AuthUserModel.fromCredential(UserCredential credentials) {
    final user = credentials.user;

    if (user == null) {
      throw UserIsNullException("UserCredential não contém um usuário válido");
    }

    return AuthUserModel(
      uid: user.uid,
      email: user.email ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"uid": uid, "email": email};
  }

  AuthUserEntity toEntity(){
    return AuthUserEntity(uid: uid, email: email);
  }
}
