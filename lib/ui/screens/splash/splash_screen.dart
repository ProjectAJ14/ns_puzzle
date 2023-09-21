import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/services/services.dart';
import '../../routes/route_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2000), redirectUser);
  }

  Future<void> redirectUser() async {
    //bool isAuthenticated = await SPService.isAuthenticated();
    if (authService.isAuthenticated) {
      Get.offNamed(RouteConstants.home);
    } else {
      Get.offNamed(RouteConstants.signIn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/ns-loader-3.gif',
          width: 200,
        ),
      ),
    );
  }
}
