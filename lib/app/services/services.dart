import 'package:get/get.dart';

import '../../data/models/user.dart';
import 'auth/auth_service.dart';
import 'auth/auth_service_impl.dart';

initServices() {
  Get.put<AuthService<User?>>(AuthServiceImpl());
}

AuthService<User?> get authService => Get.find<AuthService<User?>>();
