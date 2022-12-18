import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../data/models/subjects.dart';

class SubjectWidget extends StatelessWidget {
  const SubjectWidget({
    Key? key,
    required this.subject,
    required this.onSubjectTap,
    required this.subjectWidth,
    required this.subjectHeight,
  }) : super(key: key);

  final Subject subject;
  final Function(Subject subject) onSubjectTap;
  final double subjectWidth;
  final double subjectHeight;

  @override
  Widget build(BuildContext context) {
    if (subject.isDead) {
      return Image.asset(
        'assets/images/chicken.png',
        fit: BoxFit.fill,
        width: subjectWidth,
        height: subjectHeight,
      ).animate().shake(duration: 1.seconds).then(delay: 300.ms).hide(
            duration: 500.ms,
          );
    }

    return GestureDetector(
      onTap: () => onSubjectTap(subject),
      child: Image.asset(
        subject.image,
        fit: BoxFit.fill,
        width: subjectWidth,
        height: subjectHeight,
      ),
    );
  }
}
