import 'dart:developer' as developer;

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'sp_service.dart';

import '../../../ui/screens/sign_in/sign_in_screen.dart';
import '../../../ui/utils/app_loader.dart';
import '../../models/app_response.dart';

const noCredentialsWereFound = 'No credentials were found';

AuthService get auth => Get.find<AuthService>();

class AuthService {
  final _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  bool get isAuthenticated => _firebaseAuth.currentUser != null;
  String get userId => isAuthenticated ? _firebaseAuth.currentUser!.uid : '';

  String get userEmail =>
      isAuthenticated ? _firebaseAuth.currentUser!.email ?? '' : '';
  String get userName =>
      isAuthenticated ? _firebaseAuth.currentUser!.displayName ?? '' : '';

  Future<AppResponse> signInWithGoogle() async {
    developer.log('signInWithGoogle');
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        if (googleAuth.accessToken != null || googleAuth.idToken != null) {
          final firebase_auth.UserCredential userCredential =
              await _firebaseAuth.signInWithCredential(
            firebase_auth.GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            ),
          );
          if (userCredential.user != null) {
            return AppResponse.success(
              id: 'signInWithGoogle',
            );
          }
        } else {
          developer.log(
            'googleAuth accessToken[${googleAuth.accessToken}]'
            ' idToken[${googleAuth.idToken}]',
          );
        }
      } else {
        developer.log('googleSignInAccount is [$googleSignInAccount]');
      }
    } catch (e, s) {
      return AppResponse.error(
        id: 'signInWithGoogle',
        error: e,
        stackTrace: s,
      );
    }

    return AppResponse.error(
      id: 'signInWithGoogle',
      message: noCredentialsWereFound,
    );
  }

  Future<void> signOut() async {
    try {
      AppLoader.show();
      await _firebaseAuth.signOut();
      await SPService.clear();
      Get.offAll(() => const SignInScreen());
    } catch (error, stackTrace) {
      developer.log(
        'signOut',
        error: error,
        stackTrace: stackTrace,
      );
    } finally {
      AppLoader.hide();
    }
  }
}
