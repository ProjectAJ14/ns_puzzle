import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../firebase_options.dart';
import '../../ui/utils/app_loader.dart';
import '../repo/repos.dart';
import '../services/auth/sp_service.dart';
import '../services/services.dart';

Future<void> initDependencies() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await AppLoader.init();
  await SPService.init();
  initRepos();
  initServices();
}
