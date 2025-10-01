import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/get_it/get_it.dart';
import 'package:taskly/features/auth/domain/usecases/sign_in_use_case.dart';

final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  return getIt<SignInUseCase>();
});
