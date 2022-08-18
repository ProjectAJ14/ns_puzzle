import 'dart:math' as math; // import this

import 'package:flutter/material.dart';

import '../../../../data/models/subjects.dart';
import '../../../utils/constant.dart';
import 'subject_widget.dart';

class BoatWidget extends StatelessWidget {
  const BoatWidget({
    Key? key,
    required this.isBoatOnLeftSide,
    required this.subjects,
    required this.alignment,
    required this.onSubjectTap,
  }) : super(key: key);

  final bool isBoatOnLeftSide;
  final List<Subject> subjects;
  final AlignmentGeometry alignment;
  final Function(Subject subject) onSubjectTap;

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
              bottom: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: subjects
                    .map(
                      (subject) => SubjectWidget(
                        onSubjectTap: onSubjectTap,
                        subject: subject,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
