import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../ui/utils/app_loader.dart';
import '../../../ui/utils/constant.dart';
import '../../../data/models/app_response.dart';
import '../../../data/models/user.dart';
import 'firestore_repo.dart';

class FireStoreRepoImpl extends FireStoreRepo {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  addUser({
    required User user,
  }) {
    // Call the user's CollectionReference to add a new user
    users.doc(user.userId).set({
      Constants.email: user.email,
      Constants.displayName: user.displayName,
      Constants.score: user.score,
    }).catchError((error) => debugPrint('Error adding user $error'));
  }

  @override
  Future<AppResponse> getAllTopScoredUsers() async {
    try {
      AppLoader.show();
      List<User> userList =
          await users.orderBy(Constants.score, descending: true).get().then(
                (value) => value.docs
                    .map(
                      (e) => User.fromMap(e.data() as Map<String, dynamic>),
                    )
                    .toList(),
              );

      return AppResponse.success(
        id: 'getAllTopScoredUsers',
        data: {Constants.userList: userList},
      );
    } catch (e, s) {
      return AppResponse.error(
        id: 'getAllTopScoredUsers',
        error: e,
        stackTrace: s,
      );
    } finally {
      AppLoader.hide();
    }
  }
}
