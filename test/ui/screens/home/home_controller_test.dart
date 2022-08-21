import 'package:flutter_test/flutter_test.dart';
import 'package:ns_puzzle/ui/screens/home/home_controller.dart';

void main() {
  HomeController homeController = HomeController();

  //Test: Boat is not on the left initially
  test('Boat is on the left initially', () {
    expect(homeController.isBoatOnLeftSide, false);
  });

  //Test: Boat is on the right initially
  test('Boat is on the right initially', () {
    expect(homeController.isBoatOnRightSide, true);
  });

  //Test: Boat is empty initially
  test('Boat is not full initially', () {
    expect(homeController.isBoatNotFull, true);
    expect(homeController.isBoatFull, false);
  });

  //Test: Left side is empty initially
  test('Left side is empty initially', () {
    expect(homeController.leftSide.isEmpty, true);
  });

  //Test: Right side is not empty initially
  test('Right side is empty not initially', () {
    expect(homeController.rightSide.isNotEmpty, true);
  });
}
