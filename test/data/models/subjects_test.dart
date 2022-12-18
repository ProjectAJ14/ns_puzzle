import 'package:flutter_test/flutter_test.dart';
import 'package:ns_puzzle/data/models/subjects.dart';

void main() {
// Test: Devil toString
  test('Devil toString', () {
    expect(Devil().toString(), 'Devil');
  });

// Test: Priest toString
  test('Priest toString', () {
    expect(Priest().toString(), 'Priest');
  });

  //Test: Devil image
  test('Devil image', () {
    expect(Devil().image, 'assets/images/devil.png');
  });

// Test: Priest image
  test('Priest image', () {
    expect(Priest().image, 'assets/images/priest.png');
  });
}
