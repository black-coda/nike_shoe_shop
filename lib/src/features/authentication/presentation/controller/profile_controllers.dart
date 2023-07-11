import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';

final displayNameFutureProvider = FutureProvider.autoDispose<List<String>>((ref) async {
  final displayName =
      await ref.watch(authStateNotifierProvider.notifier).displayName ?? '';
  final email = await ref.watch(authStateNotifierProvider.notifier).email;
  return [displayName, email!];
});
