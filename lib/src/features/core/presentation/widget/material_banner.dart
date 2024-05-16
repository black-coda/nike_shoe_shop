import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/src/constant/konstant.dart';

MaterialBanner showActionMaterialBanner(
    BuildContext context, String message, [String ? imageUrl]) {
  return MaterialBanner(
    content: Text(message),
    leading: CircleAvatar(
      child: CachedNetworkImage(
        imageUrl: imageUrl ?? AuthKonstant.defaultBannerShoe,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    ),
    actions: [
      TextButton(
        child: const Text('close'),
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        },
      ),
    ],
  );
}

