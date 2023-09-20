import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ns_utils/extensions/map.dart';

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
        .doc(user.email)
        .set({
          Constants.displayName: user.displayName,
          Constants.score: user.score,
        })
        .then((value) => debugPrint("User added successfully!"))
        .catchError((error) => debugPrint('Error adding user $error'));
  }

  Future<AppResponse> getAllTopScoredUsers() async {
    try {
      AppLoader.show();
      QuerySnapshot querySnapshot = await users.get();
      List<User> userList = [];
      List<User> top10UserList = [];
      for (var doc in querySnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;

        userList.add(
          User(
            displayName: data.getString(Constants.displayName),
            email: doc.id,
            score: data.getInt(Constants.score),
          ),
        );
      }
      userList.sort((user1, user2) {
        return user2.score.compareTo(user1.score);
      });
      for (int i = 0; i < userList.length; i++) {
        if (i <= 9) {
          top10UserList.add(userList[i]);
        }
      }
      return AppResponse.success(
        id: 'getAllTopScoredUsers',
        data: {Constants.userList: top10UserList},
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
