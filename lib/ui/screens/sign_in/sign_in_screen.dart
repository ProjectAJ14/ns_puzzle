import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nes_ui/nes_ui.dart';

import '../../utils/info_alert.dart';
import '../home/widgets/footer.dart';
import 'sign_in_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(100),
        child: Column(
          children: [
            Flexible(
              child: GetBuilder<SignInController>(
                init: SignInController(),
                builder: (controller) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 2,
                        child: NesContainer(
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Center(
                            child: Text(
                              'DEVILS\nVS\nPRIESTS',
                              style: Theme.of(context).textTheme.headlineLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: NesContainer(
                          backgroundColor: Theme.of(context).colorScheme.surface,
                          child: Center(
                            child: NesButton(
                              onPressed: () => controller.signInWithGoogle(
                                onError: (message) => showInfoDialog(
                                  context,
                                  message: message,
                                ),
                              ),
                              type: NesButtonType.primary,
                              child: const Text('Sign In with Google'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
