import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/controllers/app_bar_toggle_controller.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/widgets/product_list.dart';

// class CustomSliverAppBar extends ConsumerWidget {
//   const CustomSliverAppBar({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     bool isToggled = ref.watch(onToggleAppBarProvider);
//     return SliverAppBar(
//       backgroundColor: const Color(0xff5E9EFE),
//       elevation: 2,
//       floating: false,
//       pinned: true,
//       snap: false,
//       toolbarHeight: 80,
//       //* Height of the toolbar portion of the app bar
//       expandedHeight: 120,
//       //* Height of the app bar when fully expanded
//       collapsedHeight: 100,
//       //* Height of the app bar when collapsed (must be larger than or equal to the toolbarHeight)
//       flexibleSpace: const FlexibleSpaceBar(),
//       centerTitle: true,
//       title: const Text(
//         'Explore',
//         style: TextStyle(
//           fontSize: 32,
//           fontWeight: FontWeight.w700,
//           fontFamily: "RaleWay",
//         ),
//       ),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10.0),
//           child: IconButton(
//             onPressed: () => GoRouter.of(context).push("/cart"),
//             icon: const Icon(
//               MdiIcons.cart,
//             ),
//           ),
//         )
//       ],
//       leading: IconButton(
//         icon: const Icon(
//           MdiIcons.menu,
//           weight: 10,
//           size: 35,
//         ),
//         onPressed: () {
//           // Continue from here
//           ref.read(onToggleAppBarProvider.notifier).state = !isToggled;
//         },
//       ),
//     );
//   }
// }

class CustomSliverAppBar extends ConsumerStatefulWidget {
  const CustomSliverAppBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends ConsumerState<CustomSliverAppBar> {
  @override
  Widget build(BuildContext context) {
    // final key = ref.watch(appbarKeyProvider);
    return SliverAppBar(
      backgroundColor: const Color(0xff5E9EFE),
      elevation: 2,
      floating: false,
      pinned: true,
      snap: false,
      toolbarHeight: 80,
      //* Height of the toolbar portion of the app bar
      expandedHeight: 120,
      //* Height of the app bar when fully expanded
      collapsedHeight: 100,
      //* Height of the app bar when collapsed (must be larger than or equal to the toolbarHeight)
      flexibleSpace: const FlexibleSpaceBar(),
      centerTitle: true,
      title: const Text(
        'Explore',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          fontFamily: "RaleWay",
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: IconButton(
            onPressed: () => GoRouter.of(context).push("/cart"),
            icon: const Icon(
              MdiIcons.cart,
            ),
          ),
        ),
      ],

      // leading: IconButton(
      //   icon: const Icon(
      //     MdiIcons.menu,
      //     weight: 10,
      //     size: 35,
      //   ),
      //   onPressed: () {
      //     // key.currentState?.toggle();
      //   },
      // ),
    );
  }
}

// final appbarKeyProvider = Provider<GlobalKey<DrawerStackState>>((ref) {
//   return GlobalKey();
// });
