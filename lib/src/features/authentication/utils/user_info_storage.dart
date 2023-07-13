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
  Future<DocumentReference<Map<String, dynamic>>> getuserInformation() async {
    final alovelaceDocumentRef = await db.collection("users").doc("alovelace");
    return alovelaceDocumentRef;
  }

  //* Save user information to firegase db
  Future<bool> saveUserInformation({
    required UserId userId,
    required String displayName,
    String? email,
  }) async {
    try {
      final userInformation = await db
          .collection(FirebaseCollectionName.user)
          .where(
            FirebaseFieldName.displayName,
            isEqualTo: displayName,
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
      ).toJson();
      await db
          .collection(FirebaseCollectionName.user)
          .doc(displayName)
          .set(newUserPayload).then((value) => debugPrint("New User Created 🚀🚀🚀🚀"));
      return false;
    } catch (e) {
      e.log();
      return false;
    }
  }
}



