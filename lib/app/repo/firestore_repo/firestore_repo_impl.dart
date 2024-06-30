import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../ui/utils/constant.dart';
import '../../../data/models/user.dart';
import 'firestore_repo.dart';

class FireStoreRepoImpl extends FireStoreRepo {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  @override
  addUser({
    required User user,
  }) {
    users.doc(user.userId).set(user.toJson()).catchError(
          (error) => debugPrint("Error adding user $error"),
        );
  }

  @override
  Stream<User> topUserStream() {
    return users
        .orderBy(Constants.score, descending: true)
        .limit(1)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => User.fromJson(e.data() as Map<String, dynamic>),
              )
              .first,
        );
  }

  @override
  Stream<List<User>> leaderboardStream() {
    return users.orderBy(Constants.score, descending: true).snapshots().map(
          (event) => event.docs
              .map(
                (e) => User.fromJson(e.data() as Map<String, dynamic>),
              )
              .toList(),
        );
  }
}
