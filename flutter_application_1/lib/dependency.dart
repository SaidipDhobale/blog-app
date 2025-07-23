import 'dart:developer';
import 'dart:typed_data';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_application_1/core/navbar/bloc/navbar_bloc.dart';
import 'package:flutter_application_1/core/secrets/supabase_secrets.dart';
import 'package:flutter_application_1/core/usercubit/user_cubit.dart';
import 'package:flutter_application_1/fetures/Auth/data/datasources/supabase_auth_datasource.dart';
import 'package:flutter_application_1/fetures/Auth/data/repositories/auth_repository_imp.dart';
import 'package:flutter_application_1/fetures/Auth/domain/repositories/auth_repository.dart';
import 'package:flutter_application_1/fetures/Auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_application_1/fetures/Auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_application_1/fetures/blog/data/datasource/blog_remotesource_data.dart';
import 'package:flutter_application_1/fetures/blog/data/datasource/hivedatasource/hivedata.dart';
import 'package:flutter_application_1/fetures/blog/data/repository/Blog_repository_imp.dart';
import 'package:flutter_application_1/fetures/blog/domain/repository/blog_repository.dart';
import 'package:flutter_application_1/fetures/blog/domain/usecase/add_blog_usecase.dart';
import 'package:flutter_application_1/fetures/blog/domain/usecase/delete_blog_usecase.dart';
import 'package:flutter_application_1/fetures/blog/domain/usecase/editblog_usecase.dart';
import 'package:flutter_application_1/fetures/blog/domain/usecase/fetch_my_blog.dart';
import 'package:flutter_application_1/fetures/blog/domain/usecase/fetch_usecase.dart';
import 'package:flutter_application_1/fetures/blog/domain/usecase/hiveimages_usecase.dart';
import 'package:flutter_application_1/fetures/blog/presentation/bloc/blog_bloc.dart';
import 'package:flutter_application_1/fetures/blog/presentation/cubit/currentblog_cubit.dart';
import 'package:flutter_application_1/fetures/profile/data/datasource/supabase_profile.dart';
import 'package:flutter_application_1/fetures/profile/data/repository/profile_repository_imp.dart';
import 'package:flutter_application_1/fetures/profile/domain/repository/profile_repository_interface.dart';
import 'package:flutter_application_1/fetures/profile/domain/usecases/edit_profile_usecase.dart';
import 'package:flutter_application_1/fetures/profile/domain/usecases/profile_usecase.dart';
import 'package:flutter_application_1/fetures/profile/presentation/bloc/profile_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator=GetIt.instance;

Future<void> initalAuth()async{
  init();
      final  supabase=await Supabase.initialize(url:SupabaseSecret.url , anonKey: SupabaseSecret.anon);
      serviceLocator.registerLazySingleton(() => supabase.client);
      serviceLocator.registerLazySingleton(() => NavbarBloc());
      final Box<dynamic> box = Hive.box<Uint8List>('postImages');
      serviceLocator.registerLazySingleton(() => box);
}
Future<String> initialCloudMessaging()async{
    final firebaseMessaging= FirebaseMessaging.instance;
    final fCMToken=await firebaseMessaging.getToken();
    log("fcm-token:- $fCMToken");

    FirebaseMessaging.onMessageOpenedApp.listen((event) { 
      log("Message:- ${event.notification?.title}");
    });

    FirebaseMessaging.onMessage.listen((event) { 
      log("Message:- ${event.notification?.title}");
    });
    return fCMToken!;

   
    
}
void init(){
    serviceLocator..registerFactory(() => AuthRemoteDataSourceImp(supabaseClient: serviceLocator()))
    ..registerFactory<AuthRepository>(() => AuthRepositoryimp(authRemoteDataSourceImp: serviceLocator()))
    ..registerFactory(() => UserSignUp(authRepository: serviceLocator()))
    ..registerFactory(() => UserSignin(authRepository: serviceLocator()))
    ..registerFactory(() => IsUserLoggedIn(authRepository: serviceLocator()))
    ..registerLazySingleton(() => UserCubit())
    ..registerFactory(() => UserLogOut(authRepository: serviceLocator()))
    ..registerFactory(() => UserLoginWithGoogle(authRepository: serviceLocator()))
    ..registerLazySingleton(() => AuthBloc(userSignUp: serviceLocator(), userSignIn: serviceLocator(),userLoggedIn: serviceLocator(),userCubit: serviceLocator(),userLogOut: serviceLocator(), userLoginWithGoogle: serviceLocator()),);
}


Future<void> initalBlog()async{
  initBlog();
      
}

void initBlog(){
    serviceLocator..registerFactory(() => BlogDataSourceImp(supabaseClient:serviceLocator() ))
    ..registerFactory(() => HiveDataSourceImp(box: serviceLocator()))
    ..registerFactory<BlogRepository>(() => BlogRepositoryImp(blogDataSourceImp: serviceLocator(),hiveDataSourceImp: serviceLocator()))
    ..registerFactory(() => UploadBlog(blogRepository: serviceLocator()))
    ..registerFactory(() => FetchBlog(blogRepository: serviceLocator()))
    ..registerFactory(() => EditdBlog(blogRepository: serviceLocator()))
    ..registerLazySingleton(() => CurrentblogCubit())
    ..registerFactory(() => DeleteBlogUseCase(blogRepository: serviceLocator()))
    ..registerFactory(() =>HiveImageUseCase(blogRepository: serviceLocator()))
    ..registerFactory(() => FetchMyBlog( blogRepository:serviceLocator()))
    ..registerLazySingleton(() => BlogBloc(serviceLocator(),serviceLocator(),serviceLocator(),serviceLocator(),serviceLocator(),serviceLocator()));

}
Future<void> initalProfile()async{
  initProfile();
      
}
void initProfile(){
  serviceLocator
  ..registerFactory(() => ProfileDataSourceImp(supabaseClient: serviceLocator()))
  ..registerFactory<ProfileRepository>(() => ProfileRepositoryImp(profileDataSourceImp: serviceLocator()))
  
  ..registerFactory(() => GetProfileUsecase(profileRepository: serviceLocator()))
  ..registerFactory(() => EditProfileUsecase(profileRepository: serviceLocator()))
  ..registerLazySingleton(()=>ProfileBloc(serviceLocator(),serviceLocator()));
}


