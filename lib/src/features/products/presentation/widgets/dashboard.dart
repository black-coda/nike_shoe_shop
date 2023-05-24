import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
        padding: const EdgeInsets.all(29.0),
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
                  const Text(
                    "Home Dashboard",
                    style: TextStyle(color: Colors.deepPurple),
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
