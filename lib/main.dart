import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nes_ui/nes_ui.dart';
import '../../ui/routes/route_constants.dart';
import '../../ui/routes/routes.dart';
import 'app/init/init_dependencies.dart';

Future<void> main() async {
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final quarterTurns =
            constraints.maxWidth < constraints.maxHeight ? 1 : 0;
        return RotatedBox(
          quarterTurns: quarterTurns,
          child: GetMaterialApp(
            theme: flutterNesTheme(),
            builder: EasyLoading.init(),
            getPages: appScreens(),
            initialRoute: RouteConstants.home,
          ),
        );
      },
    );
  }
}
