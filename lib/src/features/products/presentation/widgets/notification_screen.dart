import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Notification"),
        leading: GestureDetector(
          child: const Icon(Icons.read_more),
          onTap: () async {
            await ref.read(authStateNotifierProvider.notifier).upload();

            debugPrint("I am done dude 🚀");
          },
        ),
      ),
    );
  }
}
