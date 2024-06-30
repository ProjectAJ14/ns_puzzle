import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return NesContainer(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        children: [
          const Text(
            'Made with Flutter',
          ),
          const Icon(
            Icons.favorite,
            color: Colors.red,
            size: 12,
          ),
          const Spacer(),
          Image.asset(
            'assets/icons/logo.png',
            width: 100,
          ),
        ],
      ),
    );
  }
}
