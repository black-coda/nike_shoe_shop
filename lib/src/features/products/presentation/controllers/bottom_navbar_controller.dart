import 'package:flutter_riverpod/flutter_riverpod.dart';

//? Bottom state declaration
class BottomNavBarStateNotifier extends StateNotifier<int> {
  BottomNavBarStateNotifier(super._state);

  void setIndexPosition(int indexValue) {
    state = indexValue;
  }
}

final selectIndexStateProvider =
    StateNotifierProvider<BottomNavBarStateNotifier, int>((ref) {
  return BottomNavBarStateNotifier(0);
});
