import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/controllers/bottom_navbar_controller.dart';
import 'package:nike_shoe_shop/src/utils/custom_curved_nav_bar.dart';

class ScaffoldWithNavBar extends ConsumerStatefulWidget {
  final Widget child;
  const ScaffoldWithNavBar(this.child, {super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<ScaffoldWithNavBar> {
  @override
  Widget build(BuildContext context) {
    final indexPosition = ref.watch(selectIndexStateProvider);
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.transparent,
      body: widget.child,
      bottomNavigationBar: Material(
        elevation: 2,
        child: CustomCurvedNavigationWidget(
          items: [
            CurvedNavigationBarItem(
                iconData: MdiIcons.homeOutline, selectedIconData: MdiIcons.home),
            CurvedNavigationBarItem(
                iconData: MdiIcons.heartOutline,
                selectedIconData: MdiIcons.heart),
            CurvedNavigationBarItem(
                iconData: MdiIcons.bellOutline,
                selectedIconData: MdiIcons.bellAlert),
            CurvedNavigationBarItem(
                iconData: MdiIcons.accountOutline,
                selectedIconData: MdiIcons.account),
          ],
          currentIndex: indexPosition,
          onTap: (indexPosition) => _onTap(indexPosition),
        ),
      ),
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



      
