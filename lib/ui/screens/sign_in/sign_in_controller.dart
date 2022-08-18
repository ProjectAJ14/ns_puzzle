import 'dart:developer' as developer;

import 'package:get/get.dart';

import '../../../data/models/app_response.dart';
import '../../../data/services/auth/auth_service.dart';
import '../../routes/route_constants.dart';
import '../../utils/app_loader.dart';
import '../../utils/info_alert.dart';

class SignInController extends GetxController {
  Future<void> signInWithGoogle() async {
    try {
      developer.log("_signInWithGoogle");
      AppLoader.show();
      AppResponse appResponse = await auth.signInWithGoogle();
      if (appResponse.isSuccess) {
        Get.offAllNamed(RouteConstants.home);
      } else {
        errorDialog(appResponse.message);
      }
    } catch (e, s) {
      developer.log("_signInWithGoogle", error: e, stackTrace: s);
    } finally {
      AppLoader.hide();
    }
  }
}
