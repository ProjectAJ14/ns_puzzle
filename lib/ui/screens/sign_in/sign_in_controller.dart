import 'dart:developer' as developer;

import 'package:get/get.dart';

import '../../../app/services/services.dart';
import '../../../data/models/app_response.dart';
import '../../routes/route_constants.dart';
import '../../utils/app_loader.dart';
import '../../utils/info_alert.dart';

class SignInController extends GetxController {
  Future<void> signInWithGoogle() async {
    try {
      developer.log("_signInWithGoogle");
      AppLoader.show();
      AppResponse appResponse = await authService.signInWithGoogle();
      if (appResponse.isSuccess) {
        //await SPService.setAuthenticated(true);
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
