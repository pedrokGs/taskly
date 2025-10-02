import 'package:equatable/equatable.dart';

class AuthUserEntity extends Equatable{
  final String uid;
  final String email;

  const AuthUserEntity({
    required this.uid,
    required this.email,
  });

  static const AuthUserEntity empty = AuthUserEntity(uid: '', email: '');

  bool get isEmpty => this == AuthUserEntity.empty;

  @override
  List<Object?> get props => [uid, email];


}