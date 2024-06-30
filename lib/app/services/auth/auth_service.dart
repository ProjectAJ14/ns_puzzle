import '../../../data/models/app_response.dart';

abstract class AuthService<T> {
  bool get isAuthenticated;
  String get userId;
  String get userEmail;
  String get userName;
  String get photoURL;
  Future<AppResponse> signInWithGoogle();
  Stream<T?> authStateChanges();
  Future<void> signOut();
}
