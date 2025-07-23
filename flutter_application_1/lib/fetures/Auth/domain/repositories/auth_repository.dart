import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/fetures/Auth/data/models/user_model.dart';
import 'package:flutter_application_1/fetures/Auth/domain/entities/user_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository{
    Future<Either<Failure,User>> sinUpWithEmailAndpassword(
      {required String name,required String email,required String password}
    );

    Future<Either<Failure,User>> loginWithEmailAndpassword(
      {required String email,required String password}
    );

    Future<Either<Failure,User>> getCurrentUserLoggedIn();

    Future<Either<Failure,String>> logOut();

    Future<Either<Failure,User>> loginwithGoogle();

}