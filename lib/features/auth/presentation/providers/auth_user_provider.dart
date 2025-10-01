import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/get_it/get_it.dart';
import 'package:taskly/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taskly/features/auth/domain/entities/auth_user_entity.dart';

final authUserProvider = StreamProvider<AuthUserEntity?>((ref){
  final repository = getIt<AuthRepositoryImpl>();
  return repository.authUser;
});