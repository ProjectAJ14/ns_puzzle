abstract class Subject {
  String get image => '';
}

class Devil extends Subject {
  @override
  String toString() => 'Devil';

  @override
  String get image => 'assets/images/devil2.png';
}

class Priest extends Subject {
  @override
  String toString() => 'Priest';

  @override
  String get image => 'assets/images/priest2.png';
}
