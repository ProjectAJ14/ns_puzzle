import 'package:flutter/material.dart';

import '../../../../data/models/subjects.dart';
import '../../../utils/constant.dart';

class SubjectWidget extends StatelessWidget {
  const SubjectWidget({
    Key? key,
    required this.subject,
    required this.onSubjectTap,
  }) : super(key: key);

  final Subject subject;
  final Function(Subject subject) onSubjectTap;

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
