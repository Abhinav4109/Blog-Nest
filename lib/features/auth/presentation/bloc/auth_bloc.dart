// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_nest/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_nest/core/usecase/usecase.dart';
import 'package:blog_nest/core/common/entities/user.dart';
import 'package:blog_nest/features/auth/domain/usecases/current_user.dart';
import 'package:blog_nest/features/auth/domain/usecases/user_signin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_nest/features/auth/domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;
  final UserSignin _userSignin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc(
    this._userSignup,
    this._userSignin,
    this._currentUser,
    this._appUserCubit,
  ) : super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<IsUserSignedIn>(_isUserSignedIn);
  }

  void _isUserSignedIn(IsUserSignedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());

    res.fold((failure) => emit(AuthFailure(message: failure.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignup(UserSignUpParams(
        email: event.email, password: event.password, name: event.name));

    res.fold((failure) => emit(AuthFailure(message: failure.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final res = await _userSignin(
        UserSignInParams(email: event.email, password: event.password));
    res.fold((failure) => emit(AuthFailure(message: failure.message)),
        (user) => _emitAuthSuccess(user, emit));
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
