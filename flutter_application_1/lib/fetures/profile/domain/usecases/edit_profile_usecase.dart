// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:fpdart/src/either.dart';

import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/core/usecases/usecase.dart';
import 'package:flutter_application_1/fetures/profile/domain/entity/profile_entity.dart';
import 'package:flutter_application_1/fetures/profile/domain/repository/profile_repository_interface.dart';

class EditProfileUsecase implements Usecase<Profile,Editparam> {
  ProfileRepository profileRepository;
  EditProfileUsecase({
    required this.profileRepository,
  });
  @override
  Future<Either<Failure, Profile>> call(Editparam param)async {
    return await profileRepository.editProfileData(name: param.name, email: param.email, imageurl: param.imageurl, mobileno: param.mobileno, userid: param.userid,isImageChanged: param.imageChanged,imagenetwork: param.imagenetwork); 
  }

}

class Editparam {
    final String userid;
    final String imagenetwork;
  final String name;
  bool imageChanged;
  final String email;
  final int mobileno;
  final File imageurl;
  Editparam({
    required this.imagenetwork,
    required this.imageChanged,
    required this.userid,
    required this.name,
    required this.email,
    required this.mobileno,
    required this.imageurl,
  });
  
 
}
