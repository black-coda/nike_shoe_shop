import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';

final displayNameFutureProvider = FutureProvider<String>((ref) async {
  final displayName =
      await ref.watch(authStateNotifierProvider.notifier).displayName ?? '';
  return displayName;
});
