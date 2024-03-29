import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show debugPrint, immutable;
import 'package:nike_shoe_shop/src/features/authentication/utils/firebase_collection_name.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/firebase_field_name.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/user_info_payload.dart';
import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';

@immutable
class UserInfoStorage {
  final db = FirebaseFirestore.instance;

  //* Retrieve user information
  Future<Map<String, dynamic>> getUserInformation(
      UserId id, String displayName) async {
    final userInstance = db.collection("users");

    final userQuery = await userInstance
        .where("displayName", isEqualTo: displayName)
        .limit(1)
        .get();
    // .then(
    //   (queries) {

    //     for (var query in queries.docs) {
    //       return query.data();
    //     }
    //   },
    // );

    final userData = userQuery.docs.first.data();
    return userData;
    // for (var data in userData) {
    //   final udata =  data.data();
    // }

    // return null;
  }

  //* Save user information to firebase db
  Future<bool> saveUserInformation({
    required UserId userId,
    required String displayName,
    String? photoUrl,
    String? email,
  }) async {
    try {
      final userInformation = await db
          .collection(FirebaseCollectionName.user)
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userId,
          )
          .limit(1)
          .get();
      if (userInformation.docs.isNotEmpty) {
        //? user's info present
        await userInformation.docs.first.reference.update(
          {
            FirebaseFieldName.displayName: displayName,
            FirebaseFieldName.email: email,
          },
        );
        return true;
      }
      //? if is user not present

      //* create user-info payload
      final newUserPayload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
        photoUrl: photoUrl,
      ).toJson();
      newUserPayload.log();
      await db
          .collection(FirebaseCollectionName.user)
          .doc(userId)
          .set(newUserPayload)
          .then((value) => debugPrint("New User Created 🚀🚀🚀🚀"));
      return false;
    } catch (e) {
      e.log();
      return false;
    }
  }
}
