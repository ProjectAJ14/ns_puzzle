import 'dart:math' as math; // import this

import 'package:flutter/material.dart';

class BoatWidget extends StatelessWidget {
  const BoatWidget({
    Key? key,
    required this.isBoatOnLeftSide,
    required this.alignment,
    required this.children,
    required this.boatWidth,
    required this.boatHeight,
    required this.boatPadding,
  }) : super(key: key);

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
      duration: const Duration(seconds: 2),
      child: SizedBox(
        height: boatHeight,
        width: boatWidth,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Transform(
              alignment: Alignment.center,
              transform: isBoatOnLeftSide
                  ? Matrix4.rotationY(0)
                  : Matrix4.rotationY(math.pi), //Mirror Widget
              child: Image.asset(
                'assets/images/boat.png',
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: boatPadding,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
