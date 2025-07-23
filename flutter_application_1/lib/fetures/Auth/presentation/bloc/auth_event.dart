// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthSignUp extends AuthEvent {
    String email;
    String password;
    String name;
  AuthSignUp({
    required this.email,
    required this.password,
    required this.name,
  });
    
}
class AuthSignIn extends AuthEvent {
    String email;
    String password;
  AuthSignIn({
    required this.email,
    required this.password,
  });


}

class AuthReset extends AuthEvent{

}

class AuthLoggedIn extends AuthEvent{

}

class AuthLogOut extends AuthEvent{
  
}

class AuthSignInGoogleEvent extends AuthEvent{
  
}
