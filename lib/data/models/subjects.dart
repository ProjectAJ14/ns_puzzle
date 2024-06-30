abstract class Subject {
  String get image => '';

  bool get isDead => false;
}

class Devil extends Subject {
  @override
  String toString() => 'Devil';

  bool _animate = false;

  set animate(bool value) {
    _animate = value;
  }

  @override
  String get image =>
      _animate ? 'assets/images/devil.gif' : 'assets/images/devil.png';
}

class Lady extends Subject {
  @override
  String toString() => 'Lady';

  bool _isDead = false;

  void markDead() {
    _isDead = true;
  }

  @override
  bool get isDead => _isDead;

  @override
  String get image => 'assets/images/lady.png';
}
