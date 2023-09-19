import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

final successBanner = MaterialBanner(
  content: const Text('👟 added to favorites!'),
  leading: const Icon(Icons.thumb_up, color: Colors.white,),
  backgroundColor: const Color(0xff00a4d0),
  actions: [
    TextButton(
      onPressed: () {
        // Handle the action (e.g., undo or navigate to favorites)
      },
      child: const Text('Undo'),
    ),
  ],
);

final failsBanner = MaterialBanner(
  content: const Text('Error during process 😪'),
  leading: const Icon(Icons.thumb_up, color: Colors.white,),
  backgroundColor: const Color(0xff00a4d0),
  actions: [
    TextButton(
      onPressed: () {
        // Handle the action (e.g., undo or navigate to favorites)
      },
      child: const Text('Undo'),
    ),
  ],
);

final successCartBanner = MaterialBanner(
  /// need to set following properties for best effect of awesome_snackbar_content
  elevation: 0,
  backgroundColor: Colors.transparent,
  forceActionsBelow: true,
  content: AwesomeSnackbarContent(
    title: 'Success',
    message:
        '👟 added to cart 🛒',
    contentType: ContentType.success,
    // to configure for material banner
    inMaterialBanner: true,
  ),
  actions: const [SizedBox.shrink()],
);


final failedCartBanner = MaterialBanner(
  /// need to set following properties for best effect of awesome_snackbar_content
  elevation: 0,
  backgroundColor: Colors.transparent,
  forceActionsBelow: true,
  content: AwesomeSnackbarContent(
    title: 'Success',
    message: '👟 added to cart 🛒',
    contentType: ContentType.failure,
    // to configure for material banner
    inMaterialBanner: true,
  ),
  actions: const [SizedBox.shrink()],
);


void scaffoldMessenger(context) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showMaterialBanner(successCartBanner);
}
