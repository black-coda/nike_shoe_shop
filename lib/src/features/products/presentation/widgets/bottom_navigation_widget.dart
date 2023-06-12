import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/controllers/bottom_navbar_controller.dart';

class BottomNavigationWidget extends ConsumerStatefulWidget {
  const BottomNavigationWidget({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState
    extends ConsumerState<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    final indexPosition = ref.watch(selectIndexStateProvider);
    debugPrint(indexPosition.toString());
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xff1b1f50),
      selectedIconTheme: const IconThemeData().copyWith(color: Colors.pink),
      onTap: (indexPosition) => _onTap(indexPosition),
      currentIndex: indexPosition,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.home),
          label: "Home",
          activeIcon: Icon(Icons.home_sharp),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          label: "Favorite",
          activeIcon: Icon(Icons.favorite_sharp),
        ),
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.bellAlertOutline),
          label: "Home",
          activeIcon: Icon(Icons.notifications_sharp),
        ),
        BottomNavigationBarItem(
          icon: Icon(MdiIcons.accountOutline),
          label: "Home",
          activeIcon: Icon(Icons.person_3_sharp),
        ),
      ],
    );
  }

  void _onTap(int index) {
    ref.watch(selectIndexStateProvider.notifier).setIndexPosition(index);
    switch (index) {
      case 0:
        context.go("/productList");
        break;
      case 1:
        context.go("/favorite");
        break;
      case 2:
        context.go("/notification");
        break;
      case 3:
        context.go("/profile");
        break;
      default:
    }
  }
}
