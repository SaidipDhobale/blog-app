part of 'auth_bloc.dart';


sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSucess  extends AuthState{

    User user;
    AuthSucess(this.user);
}

final class AuthFailure extends AuthState{
    String message;
    AuthFailure(this.message);
}

final class AuthLoading extends AuthState{}


final class GoogleSignInSucess extends AuthState{
  String message;
  GoogleSignInSucess({required this.message});
}