part of 'profile_bloc.dart';

sealed class ProfileEvent {}

final class GetProfileDataEvent extends ProfileEvent {
  String id;
  GetProfileDataEvent({required this.id});
}

final class EditProfileDataEvent extends ProfileEvent {
  String id;
  String name;
  String email;
  int mobileno;
  File imageurl;
  bool imageChanged;
  String imagenetwork;
  EditProfileDataEvent({
    required this.imagenetwork,
    required this.imageChanged,
    required this.id,
    required this.email,
    required this.imageurl,
    required this.mobileno,
    required this.name,
  });
}
