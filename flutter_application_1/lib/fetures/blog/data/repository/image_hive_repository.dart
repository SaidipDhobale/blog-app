// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/src/either.dart';

import 'package:flutter_application_1/core/error/failure.dart';
import 'package:flutter_application_1/fetures/blog/data/Models/post_image_model.dart';
import 'package:flutter_application_1/fetures/blog/data/datasource/hivedatasource/hivedata.dart';
import 'package:flutter_application_1/fetures/blog/domain/repository/hive_image_repo.dart';

class ImageHiveRepository implements HiveImageRepo {
  HiveDataSourceImp hiveDataSourceImp;
  ImageHiveRepository({
    required this.hiveDataSourceImp,
  });
  @override
  Future<Either<Failure, List<PostImage>>> getAllImagesFromHive()async {
    try{
        final res=await hiveDataSourceImp.getAllImagesFromHive();
        return right(res);
    }catch(e){
        return left(Failure(e.toString()));
    }
  }
  
}
