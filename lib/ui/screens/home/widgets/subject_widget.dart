import 'package:flutter/material.dart';

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
