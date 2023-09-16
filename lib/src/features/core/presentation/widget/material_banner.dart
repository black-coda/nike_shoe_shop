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
