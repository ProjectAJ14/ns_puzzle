import 'package:get/get.dart';

import 'firestore_repo/firestore_repo.dart';
import 'firestore_repo/firestore_repo_impl.dart';

initRepos() {
  Get.put<FireStoreRepo>(FireStoreRepoImpl());
}

FireStoreRepo get fireStoreRepo => Get.find<FireStoreRepo>();
