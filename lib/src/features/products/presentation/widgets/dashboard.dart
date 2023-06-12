import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/controllers/bottom_navbar_controller.dart';
import 'package:nike_shoe_shop/src/utils/custom_curved_nav_bar.dart';

class DashBoardView extends ConsumerWidget {
  const DashBoardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SvgPicture.asset("assets/svg/Hamburger.svg"),
          SvgPicture.asset("assets/svg/explore.svg"),
          const Icon(MdiIcons.cart),
          const Icon(Icons.shopify_outlined)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        ref
                            .read(authStateNotifierProvider.notifier)
                            .logoutUser();
                      },
                      child: const Icon(Icons.logout)),
                  GestureDetector(
                    onTap: () => context.go("location"),
                    child: const Text(
                      "Home Dashboard",
                      style: TextStyle(color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashBoardScreen extends ConsumerStatefulWidget {
  final Widget child;
  const DashBoardScreen(this.child, {super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DashBoardScreenState();
}

class _DashBoardScreenState extends ConsumerState<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    final indexPosition = ref.watch(selectIndexStateProvider);
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: CustomCurvedNavigationWidget(
        items: [
          CurvedNavigationBarItem(iconData: MdiIcons.home),
          CurvedNavigationBarItem(iconData: MdiIcons.heart),
          CurvedNavigationBarItem(iconData: MdiIcons.bell),
          CurvedNavigationBarItem(iconData: MdiIcons.account),
        ],
        onTap: _onTap(indexPosition),
      ),
    );
  }

  _onTap(int index) {
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

// class DashBoardScreen extends ConsumerWidget {
//   final Widget child;
//   const DashBoardScreen(this.child, {super.key});
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       backgroundColor: const Color(0xff451228),
//       body: child,
//       bottomNavigationBar: const BottomNavigationWidget(),
//     );
//   }
// }

      
