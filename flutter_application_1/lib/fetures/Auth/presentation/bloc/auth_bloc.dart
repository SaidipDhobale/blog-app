import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_1/core/usercubit/user_cubit.dart';
import 'package:flutter_application_1/fetures/Auth/domain/entities/user_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/fetures/Auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignin _userSignin;
  final IsUserLoggedIn _isLoggedIn;
  final UserCubit _userCubit;
  final UserLogOut _userLogOut;
  final UserLoginWithGoogle _userLoginWithGoogle;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignin userSignIn,
    required IsUserLoggedIn userLoggedIn,
    required UserCubit userCubit,
    required UserLogOut userLogOut,
    required UserLoginWithGoogle userLoginWithGoogle,
  })  : _userSignUp = userSignUp,
        _userSignin = userSignIn,
        _isLoggedIn = userLoggedIn,
        _userCubit = userCubit,
        _userLogOut = userLogOut,
        _userLoginWithGoogle = userLoginWithGoogle,
        super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(AuthLoading());
    });
    on<AuthSignUp>((event, emit) async {
      // emit(AuthLoading());
      log("in auth bloc");
      final response = await _userSignUp(UserSignUpParams(
          name: event.name, password: event.password, email: event.email));
      response.fold((l) => emit(AuthFailure(l.message)), (r) {
        _userCubit.updateUser(r);
        emit(AuthSucess(r));
      });
    });

    on<AuthSignIn>((event, emit) async {
      log('auth sign in bloc');
      final response = await _userSignin(
          UserSigninParams(password: event.password, email: event.email));
      response.fold((l) => emit(AuthFailure(l.message)), (r) {
        

        _userCubit.updateUser(r);
        emit(AuthSucess(r));
      });
    });

    on<AuthReset>((context, emit) {
      _userCubit.updateUser(null);
      emit(AuthInitial());
    });

    on<AuthLoggedIn>((event, emit) async {
      final res = await _isLoggedIn(NoParams());
      res.fold((l) => emit(AuthInitial()), (user) async{
        log("useremail:--${user.id}");
        _userCubit.updateUser(user);
        emit(AuthSucess(user));
        await FirebaseMessaging.instance.subscribeToTopic('all_users');
        await FirebaseMessaging.instance.requestPermission();
      });
    });

    on<AuthSignInGoogleEvent>((event, emit) async {
      final res = await _userLoginWithGoogle(NoParams());

      res.fold((l) => emit(AuthFailure(l.message)), (r) async{
        _userCubit.updateUser(r);
        

        emit(GoogleSignInSucess(message: "sucess"));
        await FirebaseMessaging.instance.subscribeToTopic('all_users');
        await FirebaseMessaging.instance.requestPermission();
       
        
      });
    });

    on<AuthLogOut>((event, emit) async {
      final res = await _userLogOut(NoParams());
      _userCubit.reset();
      res.fold((l) => emit(AuthFailure(l.message)), (r) => emit(AuthInitial()));
      await FirebaseMessaging.instance.unsubscribeFromTopic('all_users');
     
    });
  }
  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    log('State changed: ${change.currentState} → ${change.nextState}');
  }

  @override
  void onTransition(Transition<AuthEvent, AuthState> transition) {
    super.onTransition(transition);
    log('Event: ${transition.event}');
    log('From: ${transition.currentState}');
    log('To:   ${transition.nextState}');
  }
}
