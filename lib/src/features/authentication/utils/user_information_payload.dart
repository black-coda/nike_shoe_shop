import 'package:flutter/foundation.dart' show immutable;
import 'package:nike_shoe_shop/src/features/authentication/utils/firebase_field_name.dart';
import 'dart:collection' show MapView;

import 'package:nike_shoe_shop/src/features/core/domain/user_id.dart';

@immutable
class UserInformationPayload extends MapView<String,String> {
  UserInformationPayload({
   required UserId userId,
    required String? displayName,
    required String? email,
  }):super({

    FirebaseFieldName.userId:userId,
    FirebaseFieldName.displayName : displayName ?? '',
    FirebaseFieldName.email : email ?? "",
    
  });

}