import 'package:flutter/material.dart';

import '../../../app/services/services.dart';
import '../../../data/models/user.dart';
import '../game/game_screen.dart';
import '../sign_in/sign_in_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authService.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        } else {
          if (snapshot.data != null) {
            return const GameScreen();
          } else {
            return const SignInScreen();
          }
        }
      },
    );
  }
}
