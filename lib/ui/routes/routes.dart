import 'package:get/get.dart';

import '../screens/home/home_screen.dart';
import '../screens/leaderboard/leaderboard_screen.dart';
import 'route_constants.dart';

const defaultTransition = Transition.topLevel;

List<GetPage<dynamic>> appScreens() => [
      GetPage(
        name: RouteConstants.home,
        page: () => const HomeScreen(),
        transition: defaultTransition,
      ),
      GetPage(
        name: RouteConstants.leaderboard,
        page: () => const LeaderboardScreen(),
        transition: defaultTransition,
      ),
    ];
