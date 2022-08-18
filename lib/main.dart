import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'data/services/auth/auth_service.dart';
import 'data/services/auth/sp_service.dart';
import 'ui/screens/splash/splash_screen.dart';
import 'ui/theme/theme.dart';
import 'ui/utils/app_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLoader.init();
  await SPService.init();
  Get.put(AuthService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: theme,
      home: const SplashScreen(),
      builder: EasyLoading.init(),
    );
  }
}
