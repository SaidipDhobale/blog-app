// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'dart:developer';


import 'package:flutter_application_1/fetures/Auth/domain/entities/user_entity.dart';
import 'package:fpdart/src/either.dart';

import 'package:flutter_application_1/core/error/Exceptions.dart';
import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/fetures/Auth/data/datasources/supabase_auth_datasource.dart';
import 'package:flutter_application_1/fetures/Auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryimp implements AuthRepository {
  AuthRemoteDataSourceImp _authRemoteDataSourceImp;
  AuthRepositoryimp({
    required AuthRemoteDataSourceImp authRemoteDataSourceImp,
  }):_authRemoteDataSourceImp=authRemoteDataSourceImp;
  @override
  Future<Either<Failure, User>> loginWithEmailAndpassword({required String email, required String password}) async{
    try{
        log("in data repository");
        final user=await  _authRemoteDataSourceImp.loginWithEmailAndpassword(email:email,password: password);
        return right(user);
    } on sb.AuthException catch(e){
      log("exception-repo${Failure(e.message)}");
      return left(Failure(e.toString()));
    }catch(e){
      log("server exception${Failure(e.toString())}");
       return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> sinUpWithEmailAndpassword({required String name, required String email, required String password})async {
    log("in repo data sources");
    try{
        final id=await  _authRemoteDataSourceImp.sinUpWithEmailAndpassword(name: name, email: email, password: password);
        return right(id);
    }on ServerException catch(e){
      return left(Failure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, User>> getCurrentUserLoggedIn()async {
      try{
        final res=await _authRemoteDataSourceImp.getCurrentUser();
        if(res==null){
          return left(Failure("no user"));
        }else{
          return right(res);
        }
      }catch(e){
        return left(Failure(e.toString()));
      }
  }
  
  @override
  Future<Either<Failure,String>> logOut() async{
    try{
    await _authRemoteDataSourceImp.getLogOut();
    return right("sucess");
    }catch(e){
      return left(Failure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure,User>> loginwithGoogle()async {
    try{
        final res=await _authRemoteDataSourceImp.googleSignIn();
       return  right(res);
    }catch(e){
      return left(Failure(e.toString()));
    }
  }

  

}
