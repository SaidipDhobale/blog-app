part of 'user_cubit.dart';


sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoggedIn extends UserState{
  User user;
  UserLoggedIn(this.user);
}
