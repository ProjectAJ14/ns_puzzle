import 'dart:math' as math; // import this

import 'package:flutter/material.dart';

class BoatWidget extends StatelessWidget {
  const BoatWidget({
    super.key,
    required this.isBoatOnLeftSide,
    required this.alignment,
    required this.children,
    required this.boatWidth,
    required this.boatHeight,
    required this.boatPadding,
  });

  final bool isBoatOnLeftSide;
  final AlignmentGeometry alignment;
  final List<Widget> children;
  final double boatWidth;
  final double boatHeight;
  final double boatPadding;

  @override
  Widget build(BuildContext context) {
    return AnimatedAlign(
      alignment: alignment,
      curve: Curves.easeInOut,
      duration: const Duration(milliseconds: 1500),
      child: SizedBox(
        width: boatWidth,
        child: Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: boatPadding,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: children,
              ),
            ),
            Positioned(
              bottom: -boatHeight / 3,
              child: Transform(
                alignment: Alignment.center,
                transform: isBoatOnLeftSide
                    ? Matrix4.rotationY(0)
                    : Matrix4.rotationY(math.pi), //Mirror Widget
                child: Image.asset(
                  'assets/images/boat.png',
                  fit: BoxFit.fill,
                  height: boatHeight,
                  width: boatWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
