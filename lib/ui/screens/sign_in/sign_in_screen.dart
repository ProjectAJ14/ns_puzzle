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
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
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
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            const factor = 7;
                            final splitFactor =
                                constraints.maxWidth < constraints.maxHeight
                                    ? constraints.maxWidth
                                    : constraints.maxHeight;
                            double subjectWidth = splitFactor / factor;
                            double subjectHeight = (16 * subjectWidth) / 9;
                            return NesContainer(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                      children: [
                                        const TextSpan(text: 'LADIES'),
                                        TextSpan(
                                          text: '\nvs\n',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                        const TextSpan(text: 'DEVILS'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: subjectHeight * 0.05,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ...List.generate(
                                        6,
                                        (index) => Image(
                                          width: subjectWidth,
                                          height: subjectHeight,
                                          fit: BoxFit.fitHeight,
                                          image: AssetImage(
                                            'assets/images/${index > 2 ? 'devil' : 'lady'}.${index <= 2 ? 'gif' : 'png'}',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
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
                              child: const Text(
                                'Sign In with Google',
                                textAlign: TextAlign.center,
                              ),
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
