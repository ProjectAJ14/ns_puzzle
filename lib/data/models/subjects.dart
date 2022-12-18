abstract class Subject {
  String get image => '';

  bool get isDead => false;
}

class Devil extends Subject {
  @override
  String toString() => 'Devil';

  @override
  String get image => 'assets/images/devil.png';
}

class Priest extends Subject {
  @override
  String toString() => 'Priest';

  bool _isDead = false;

  void markDead() {
    _isDead = true;
  }

  @override
  bool get isDead => _isDead;

  @override
  String get image => 'assets/images/priest.png';
}
