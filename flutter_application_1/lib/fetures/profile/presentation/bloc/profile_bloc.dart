// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/fetures/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:meta/meta.dart';

import 'package:flutter_application_1/fetures/profile/domain/entity/profile_entity.dart';
import 'package:flutter_application_1/fetures/profile/domain/usecases/profile_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  GetProfileUsecase  profileUsecase;
  EditProfileUsecase editProfileUsecase;
  ProfileBloc(
    this.editProfileUsecase,
    this.profileUsecase,
  ) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {
      emit(EditLoadingState());
    },);
    on<GetProfileDataEvent>((event, emit)async {
      final res=await profileUsecase(GetProfileId(id: event.id));
      res.fold((l) => emit(GetProfileStatefailure(message:l.message)), (r) => emit(GetProfileState(profile: r)));
    });

    on<EditProfileDataEvent>((event, emit)async {
          final res=await editProfileUsecase(Editparam(userid: event.id, name: event.name, email: event.email, mobileno:event.mobileno, imageurl: event.imageurl,imageChanged:event.imageChanged,imagenetwork: event.imagenetwork));
          res.fold((l) => emit(GetProfileStatefailure(message: l.toString())), (r) => emit(EditProfileState(profile: r)));
    },);
  }

  @override
  void onChange(Change<ProfileState> change) {
    log("${change.currentState}-> ${change.nextState}");
    super.onChange(change);
  }
}
