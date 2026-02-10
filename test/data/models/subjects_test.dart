import 'package:flutter_test/flutter_test.dart';
import 'package:ns_puzzle/data/models/subjects.dart';

void main() {
// Test: CancerCell toString
  test('CancerCell toString', () {
    expect(CancerCell().toString(), 'CancerCell');
  });

// Test: CARTCell toString
  test('CARTCell toString', () {
    expect(CARTCell().toString(), 'CARTCell');
  });

  //Test: CancerCell image
  test('CancerCell image', () {
    expect(CancerCell().image, 'assets/images/cancer-cell.png');
  });

// Test: CARTCell image
  test('CARTCell image', () {
    expect(CARTCell().image, 'assets/images/cart-t-cell.png');
  });
}
