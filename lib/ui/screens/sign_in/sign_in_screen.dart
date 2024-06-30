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
    return LayoutBuilder(
      builder: (context, snapshot) {
        const factor = 12;
        double subjectWidth = snapshot.maxWidth / factor;
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
                              child: Stack(
                                children: [
                                  Center(
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: 'DEVILS',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge,
                                          ),
                                          TextSpan(
                                            text: '\nvs\n',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                          TextSpan(
                                            text: 'LADIES',
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineLarge,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                          3,
                                          (index) => Image(
                                            width: subjectWidth,
                                            image: const AssetImage(
                                              'assets/images/lady.gif',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                          3,
                                          (index) => Image(
                                            width: subjectWidth,
                                            image: const AssetImage(
                                              'assets/images/devil.gif',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            child: NesContainer(
                              backgroundColor:
                                  Theme.of(context).colorScheme.surface,
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
      },
    );
  }
}
