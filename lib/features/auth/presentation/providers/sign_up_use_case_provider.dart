import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:taskly/core/get_it/get_it.dart';
import 'package:taskly/features/auth/domain/usecases/sign_up_use_case.dart';

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  return getIt<SignUpUseCase>();
},);