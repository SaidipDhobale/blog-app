// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter_application_1/fetures/Auth/data/repositories/auth_repository_imp.dart';
import 'package:fpdart/fpdart.dart';

import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/core/usecases/usecase.dart';
import 'package:flutter_application_1/fetures/Auth/domain/entities/user_entity.dart';
import 'package:flutter_application_1/fetures/Auth/domain/repositories/auth_repository.dart';

class UserSignUp implements Usecase<User,UserSignUpParams>{
    final AuthRepository _authRepository;
    const UserSignUp({required AuthRepository authRepository}):_authRepository=authRepository;

  @override
  Future<Either<Failure, User>> call(UserSignUpParams param)async {
    log("in use case");
   return await  _authRepository.sinUpWithEmailAndpassword(name: param.name, email: param.email, password: param.password);
  }

}
class UserSignUpParams{
  final String name;
  final String password;
  final String email;

  UserSignUpParams(
      {required this.name,required this.password,required,required this.email}
  );

}
class UserSignin implements Usecase<User,UserSigninParams>{
    final AuthRepository _authRepository;
    const UserSignin({required AuthRepository authRepository}):_authRepository=authRepository;

  @override
  Future<Either<Failure, User>> call(UserSigninParams param)async {
    log("in use case login");
   return await  _authRepository.loginWithEmailAndpassword( email: param.email, password: param.password);
  }
}
class UserSigninParams{

  final String password;
  final String email;

  UserSigninParams(
      {required this.password,required,required this.email}
  );
}

class IsUserLoggedIn implements Usecase<User,NoParams> {
  final AuthRepository _authRepository;
  IsUserLoggedIn({
    required AuthRepository authRepository,
  }):_authRepository=authRepository;
  
  @override
  Future<Either<Failure, User>> call(NoParams param)async {
      return await _authRepository.getCurrentUserLoggedIn();
  }

}
class NoParams {

}


class UserLogOut implements Usecase<String,NoParams> {
  final AuthRepository _authRepository;
  UserLogOut({
    required AuthRepository authRepository,
  }):_authRepository=authRepository;

  @override
  Future<Either<Failure,String>> call(NoParams param) async {
       return await _authRepository.logOut();
  }

}

class UserLoginWithGoogle implements Usecase<User,NoParams>{
   final AuthRepository _authRepository;
  UserLoginWithGoogle({
    required AuthRepository authRepository,
  }):_authRepository=authRepository;
  
  @override
  Future<Either<Failure, User>> call(NoParams param) async{
    return await _authRepository.loginwithGoogle();
  }
  
}

