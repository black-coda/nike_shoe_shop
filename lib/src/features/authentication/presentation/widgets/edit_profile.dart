import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateProfile extends ConsumerWidget {
  const UpdateProfile({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      backgroundColor: Colors.orangeAccent,
    );
  }
}

class UpdatedProfiled extends ConsumerWidget {
  const UpdatedProfiled({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Profile"),
      ),
    );
  }
}
