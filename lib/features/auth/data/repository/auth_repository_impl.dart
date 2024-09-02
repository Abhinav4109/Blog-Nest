import 'package:blog_nest/core/error/exceptions.dart';
import 'package:blog_nest/core/error/failures.dart';
import 'package:blog_nest/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_nest/features/auth/data/models/user_model.dart';
import 'package:blog_nest/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserModel>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if(user == null){
        return left(Failure(message: 'User not logged in'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailPassword(
      {required name, required email, required password}) {
    return _getUser(() async => await remoteDataSource.signUpWithEmailPassword(
        name: name, email: email, password: password));
  }

  @override
  Future<Either<Failure, UserModel>> loginWithEmailPassword(
      {required email, required password}) {
    return _getUser(() async => await remoteDataSource.loginWithEmailPassword(
        email: email, password: password));
  }
}

Future<Either<Failure, UserModel>> _getUser(
    Future<UserModel> Function() fn) async {
  try {
    final user = await fn();
    return right(user);
  } on ServerException catch (e) {
    return left(Failure(message: e.message));
  }
}
