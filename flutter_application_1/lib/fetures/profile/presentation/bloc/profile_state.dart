part of 'profile_bloc.dart';


sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetProfileState extends ProfileState{
  Profile profile;
  GetProfileState({required this.profile});

}
final  class GetProfileStatefailure extends ProfileState{
  String message;
  GetProfileStatefailure({required this.message});
}

final class EditProfileState extends ProfileState{
   Profile profile;
  EditProfileState({required this.profile});
}

final class EditLoadingState extends ProfileState{}