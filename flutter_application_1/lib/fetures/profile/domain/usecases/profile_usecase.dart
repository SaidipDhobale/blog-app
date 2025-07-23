// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/src/either.dart';

import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/core/usecases/usecase.dart';
import 'package:flutter_application_1/fetures/profile/domain/entity/profile_entity.dart';
import 'package:flutter_application_1/fetures/profile/domain/repository/profile_repository_interface.dart';
class GetProfileUsecase implements Usecase<Profile,GetProfileId> {
  ProfileRepository profileRepository;
  GetProfileUsecase({
    required this.profileRepository,
  });
  @override
  Future<Either<Failure, Profile>> call(GetProfileId param)async {
    return await profileRepository.getProfileData(param.id) ;
  }

}

class GetProfileId {
  String id;
  GetProfileId({
    required this.id,
  });
  
}
