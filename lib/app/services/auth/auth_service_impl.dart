import '../../../data/models/app_response.dart';
import '../../../data/models/user.dart';
import '../../../ui/utils/constant.dart';
import 'auth_service.dart';
import 'dart:developer' as developer;
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import '../../../ui/utils/app_loader.dart';

class AuthServiceImpl extends AuthService<User?> {
  final _firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  @override
  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  @override
  String get userId => isAuthenticated ? _firebaseAuth.currentUser!.uid : '';

  @override
  String get userEmail =>
      isAuthenticated ? _firebaseAuth.currentUser!.email ?? '' : '';

  @override
  String get userName =>
      isAuthenticated ? _firebaseAuth.currentUser!.displayName ?? '' : '';

  @override
  String get photoURL =>
      isAuthenticated ? _firebaseAuth.currentUser!.photoURL ?? '' : '';

  @override
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
      message: Constants.noCredentialsWereFound,
    );
  }

  @override
  Future<void> signOut() async {
    try {
      AppLoader.show();
      await _firebaseAuth.signOut();
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

  @override
  Stream<User?> authStateChanges() {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      if (firebaseUser == null) {
        return null;
      }
      return User(
        userId: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        displayName: firebaseUser.displayName ?? '',
      );
    });
  }
}
