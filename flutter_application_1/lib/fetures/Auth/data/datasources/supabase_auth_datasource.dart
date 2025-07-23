import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/error/exceptions.dart';
import 'package:flutter_application_1/fetures/Auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> sinUpWithEmailAndpassword(
      {required String name, required String email, required String password});

  Future<UserModel> loginWithEmailAndpassword(
      {required String email, required String password});

  UserModel? getCurrentUser();
  Future<void> getLogOut();
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  const AuthRemoteDataSourceImp({required this.supabaseClient});

  @override
  Future<UserModel> loginWithEmailAndpassword(
      {required String email, required String password}) async {
    try {
      log("in data source");
      final response = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);

      if (response.user == null) {
        throw ServerException(message: "No user Found");
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      log(e.statusCode!);
      debugPrint("AuthException: ${e.message}");
      throw ServerException(message: e.message);
    } on ServerException catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> sinUpWithEmailAndpassword(
      {required String name,
      required String email,
      required String password}) async {
    log("in data sources");
    try {
      log("in trycatch");
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {"name": name});
      log("${response.user}");
      if (response.user == null) {
        log("serverexception");
        throw ServerException(message: "user not found");
      }
      return UserModel.fromJson(response.user!.toJson());
    } on AuthException catch (e) {
      // Supabase auth-specific error
      log(e.statusCode!);
      debugPrint("AuthException: ${e.message}");
      throw ServerException(message: e.message); // your custom exception
    } catch (e) {
      log("catch exception");
      throw ServerException(message: e.toString());
    }
  }

  @override
  UserModel? getCurrentUser() {
    try {
      final session = supabaseClient.auth.currentSession;

      if (session != null) {
        log("session:_${session.user.email}");
        return UserModel.fromJson(session.toJson()).copyWith(
            email: session.user.email,
            id: session.user.id,
            name: session.user.id);
      }
      return null;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<void> getLogOut() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<UserModel> googleSignIn() async {
    /// Web Client ID that you registered with Google Cloud.
    const webClientId =
        "383683973621-imf4sv1fopdac18a86jopra844khisef.apps.googleusercontent.com";

    //383683973621-imf4sv1fopdac18a86jopra844khisef.apps.googleusercontent.com
    /// iOS Client ID that you registered with Google Cloud.
    //const iosClientId = 'my-ios.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId: webClientId,
      );
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
      }
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      AuthResponse response = await supabaseClient.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      return UserModel.fromJson(response.user!.toJson());
      // return "sucess";
    } on AuthException catch (e) {
      log(e.statusCode!);
      debugPrint("AuthException: ${e.message}");
      throw ServerException(message: e.message); // your custom exception
    } catch (e) {
      log(e.toString());
      throw ServerException(message: e.toString());
    }
  }
}
