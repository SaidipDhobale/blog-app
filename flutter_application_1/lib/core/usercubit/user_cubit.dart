import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_application_1/fetures/Auth/domain/entities/user_entity.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  String? get userId => state is UserLoggedIn ? (state as UserLoggedIn).user.id : null;
  void reset() {
    emit(UserInitial());
  }

  void updateUser(User? u) {
    
    if (u == null) {
      log("initialization");
      emit(UserInitial());
    } else {
      log("userid:-${u.email}");
      User newUser = u.copyWith();
      emit(UserLoggedIn(newUser));
    }
  }
  
}
