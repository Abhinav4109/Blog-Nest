import 'package:blog_nest/core/error/exceptions.dart';
import 'package:blog_nest/core/error/failures.dart';
import 'package:blog_nest/core/network/connection_checker.dart';
import 'package:blog_nest/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_nest/features/auth/data/models/user_model.dart';
import 'package:blog_nest/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ConnectionChecker connectionChecker;

  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl(this.connectionChecker, {required this.remoteDataSource});

  @override
  Future<Either<Failure, UserModel>> currentUser() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentUserSession;

        if (session == null) {
          return left(Failure(message: 'User not logged in!'));
        }

        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
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

  Future<Either<Failure, UserModel>> _getUser(
      Future<UserModel> Function() fn) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failure(message: 'net nhi hai'));
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
