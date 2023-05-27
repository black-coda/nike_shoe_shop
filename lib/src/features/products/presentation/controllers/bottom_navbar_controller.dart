import 'package:flutter_riverpod/flutter_riverpod.dart';


//? Bottom state decleration
class BottomNavBarStateNotifier extends StateNotifier<int> {
  BottomNavBarStateNotifier() : super(0);

  void setIndexPositon(int indexValue) {
    state = indexValue;
  }
}

final selectIndexStateProvider =
    StateNotifierProvider<BottomNavBarStateNotifier, int>((ref) {
  return BottomNavBarStateNotifier();
});




