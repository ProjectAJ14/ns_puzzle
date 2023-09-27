import '../../../data/models/app_response.dart';
import '../../../data/models/user.dart';

abstract class FireStoreRepo {
  addUser({
    required User user,
  });
  Future<AppResponse> getAllTopScoredUsers();
}
