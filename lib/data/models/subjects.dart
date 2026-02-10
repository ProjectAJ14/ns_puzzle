abstract class Subject {
  String get image => '';

  bool get isDead => false;
}

class CancerCell extends Subject {
  @override
  String toString() => 'CancerCell';

  @override
  String get image => 'assets/images/cancer-cell.png';
}

class CARTCell extends Subject {
  @override
  String toString() => 'CARTCell';

  bool _isDead = false;

  void markDead() {
    _isDead = true;
  }

  @override
  bool get isDead => _isDead;

  @override
  String get image => 'assets/images/cart-t-cell.png';
}
