import 'dart:developer' as developer;

import 'package:get/get.dart';

import '../../../app/services/services.dart';
import '../../../data/models/app_response.dart';
import '../../utils/app_loader.dart';

class SignInController extends GetxController {
  Future<void> signInWithGoogle({
    required Function(String) onError,
  }) async {
    try {
      developer.log("SignInWithGoogle");
      AppLoader.show();
      AppResponse appResponse = await authService.signInWithGoogle();
      if (appResponse.isFailed) {
        onError(appResponse.message);
      }
    } catch (e, s) {
      developer.log("SignInWithGoogle", error: e, stackTrace: s);
      onError('An error occurred, please try again later.');
    } finally {
      AppLoader.hide();
    }
  }
}
