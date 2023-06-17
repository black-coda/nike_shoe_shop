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

  Future<bool> saveUserInformation({
    required UserId userId,
    required String displayName,
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
        await userInformation.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email,
        });
        return true;
      }
      //? user not present

      // creare
      final newUserPayload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
      ).toJson();
      await db
          .collection(FirebaseCollectionName.user)
          .add(newUserPayload)
          .then((value) {
        value.log();
        debugPrint("new user is created : ${value.id} ${value.toString()}");
      });
      return false;
    } catch (e) {
      e.log();
      return false;
    }
  }
}
