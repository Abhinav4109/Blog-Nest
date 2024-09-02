import 'package:blog_nest/core/error/failures.dart';
import 'package:blog_nest/core/usecase/usecase.dart';
import 'package:blog_nest/core/common/entities/user.dart';
import 'package:blog_nest/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignin implements UseCase<User, UserSignInParams>{
  final AuthRepository authRepository;

  UserSignin({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(UserSignInParams params) async {
   return await authRepository.loginWithEmailPassword(email: params.email, password: params.password);
  }
}

class UserSignInParams{
  final String email;
  final String password;

  UserSignInParams({required this.email, required this.password});
}