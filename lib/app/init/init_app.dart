import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../ui/routes/route_constants.dart';
import '../../ui/routes/routes.dart';
import '../../ui/theme/theme.dart';
import 'init_dependencies.dart';

Future<void> initApp() async {
  await initDependencies();
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
