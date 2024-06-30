import '../../../data/models/user.dart';

abstract class FireStoreRepo {
  addUser({
    required User user,
  });

  Stream<User> topUserStream();

  Stream<List<User>> leaderboardStream();
}
