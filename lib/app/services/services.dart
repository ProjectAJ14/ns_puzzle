import 'package:get/get.dart';

import 'auth/auth_service.dart';
import 'auth/auth_service_impl.dart';

initServices() {
  Get.put<AuthService>(AuthServiceImpl());
}

AuthService get authService => Get.find<AuthService>();
