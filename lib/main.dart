import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'data/services/auth/auth_service.dart';
import 'data/services/auth/sp_service.dart';
import 'firebase_options.dart';
import 'ui/routes/route_constants.dart';
import 'ui/routes/routes.dart';
import 'ui/theme/theme.dart';
import 'ui/utils/app_loader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      builder: EasyLoading.init(),
      getPages: appScreens(),
      initialRoute: RouteConstants.splashScreen,
    );
  }
}
