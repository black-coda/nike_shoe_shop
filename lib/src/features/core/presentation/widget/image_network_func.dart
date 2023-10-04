import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

CachedNetworkImage imageNetwork(List productList, int index) {
  return CachedNetworkImage(
    imageUrl: productList[index].productImage ??
        "https://hips.hearstapps.com/hmg-prod/images/legacy-fre-image-placeholder-1655513735.png?resize=980:*",
    progressIndicatorBuilder: (context, url, downloadProgress) => Center(
      child: CircularProgressIndicator(
        value: downloadProgress.progress,
        color: const Color(0xff0D6EFD),
      ),
    ),
    errorWidget: (context, url, error) =>
        const Center(child: Icon(Icons.error)),
  );
}
