import 'package:flutter_application_1/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class Usecase<SucessType,Params>{
    Future<Either<Failure,SucessType>> call(Params param);
}