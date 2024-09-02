import 'package:blog_nest/core/common/entities/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState>{
  AppUserCubit() : super(AppUserIntial()); 

  void updateUser(User? user){
    if(user==null){
      emit(AppUserIntial());
    }
    else{
      emit(AppUserSignedIn(user: user));
    }
  }
}