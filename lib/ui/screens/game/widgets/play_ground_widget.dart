import 'package:flutter/material.dart';
import 'package:nes_ui/nes_ui.dart';

import '../../../../app/services/services.dart';

class PlayGroundWidget extends StatelessWidget {
  const PlayGroundWidget({
    super.key,
    this.leftSideWidget,
    this.rightSideWidget,
    this.centerWidget,
    this.bottomLeftSideWidget,
    this.bottomRightSideWidget,
    this.bottomCenterWidget,
    required this.subjectWidth,
  });

  final Widget? leftSideWidget;
  final Widget? rightSideWidget;
  final Widget? centerWidget;
  final Widget? bottomLeftSideWidget;
  final Widget? bottomRightSideWidget;
  final Widget? bottomCenterWidget;
  final double subjectWidth;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Flexible(
              child: Container(
                color: Colors.blue.shade100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildSide(
                      child: leftSideWidget,
                    ),
                    Expanded(
                      child: Container(
                        child: centerWidget,
                      ),
                    ),
                    _buildSide(
                      child: rightSideWidget,
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildSide(
                    color: Colors.brown,
                    child: bottomLeftSideWidget,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.blue,
                      child: bottomCenterWidget,
                    ),
                  ),
                  _buildSide(
                    color: Colors.brown,
                    child: bottomRightSideWidget,
                  ),
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: Alignment.topRight,
          child: NesButton(
            type: NesButtonType.primary,
            onPressed: () {
              NesDialog.show<void>(
                context: context,
                builder: (_) => Column(
                  children: [
                    const Text('Logout?'),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        NesButton(
                          type: NesButtonType.warning,
                          onPressed: () {
                            authService.signOut();
                            Navigator.of(context).pop();
                          },
                          child: const Text('Yes'),
                        ),
                        NesButton(
                          type: NesButtonType.normal,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('No'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              child: Icon(
                Icons.logout_outlined,
                size: 28,
                color: Colors.amber,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSide({
    Color? color,
    Widget? child,
  }) {
    return Container(
      width: subjectWidth * 6,
      color: color,
      child: child,
    );
  }
}
