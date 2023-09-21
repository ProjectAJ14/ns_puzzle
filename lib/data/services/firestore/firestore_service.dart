import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ui/utils/app_loader.dart';
import '../../../ui/utils/constant.dart';
import '../../models/app_response.dart';
import '../../models/user.dart';

FireStoreService get fireStore => Get.find<FireStoreService>();

class FireStoreService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  addUser({
    required User user,
  }) {
    // Call the user's CollectionReference to add a new user
    users
        .doc(user.userId)
        .set({
          Constants.email: user.email,
          Constants.displayName: user.displayName,
          Constants.score: user.score,
        })
        .then((value) => debugPrint("User added successfully!"))
        .catchError((error) => debugPrint('Error adding user $error'));
  }

  Future<AppResponse> getAllTopScoredUsers() async {
    try {
      AppLoader.show();
      List<User> userList = await users
          //.where(Constants.score, isGreaterThan: 40)
          .orderBy(Constants.score, descending: true)
          .limit(10)
          .get()
          .then(
            (value) => value.docs
                .map(
                  (e) => User.fromFireStore(e.data() as Map<String, dynamic>),
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
