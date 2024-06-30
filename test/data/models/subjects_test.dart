import 'package:flutter_test/flutter_test.dart';
import 'package:ns_puzzle/data/models/subjects.dart';

void main() {
// Test: Devil toString
  test('Devil toString', () {
    expect(Devil().toString(), 'Devil');
  });

// Test: Lady toString
  test('Lady toString', () {
    expect(Lady().toString(), 'Lady');
  });

  //Test: Devil image
  test('Devil image', () {
    expect(Devil().image, 'assets/images/devil.png');
  });

// Test: Lady image
  test('Lady image', () {
    expect(Lady().image, 'assets/images/lady.png');
  });
}
