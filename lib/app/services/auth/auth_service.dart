import '../../../data/models/app_response.dart';

const noCredentialsWereFound = 'No credentials were found';

abstract class AuthService {
  bool get isAuthenticated;
  String get userId;
  String get userEmail;
  String get userName;
  Future<AppResponse> signInWithGoogle();
  Future<void> signOut();
}
