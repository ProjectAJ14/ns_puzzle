import 'package:get/get.dart';

import '../screens/home/home_screen.dart';
import '../screens/sign_in/sign_in_screen.dart';
import '../screens/splash/splash_screen.dart';
import 'route_constants.dart';

List<GetPage<dynamic>> appScreens() => [
      GetPage(
        name: RouteConstants.splashScreen,
        page: () => const SplashScreen(),
      ),
      GetPage(
        name: RouteConstants.signIn,
        page: () => const SignInScreen(),
      ),
      GetPage(
        name: RouteConstants.home,
        page: () => const HomeScreen(),
      ),
    ];
