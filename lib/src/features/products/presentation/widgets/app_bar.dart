import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 2,
      floating: true,
      pinned: !true,
      snap: !true,
      toolbarHeight: 100,
      //* Height of the toolbar portion of the app bar
      expandedHeight: 200,
      //* Height of the app bar when fully expanded
      collapsedHeight: 100,
      //* Height of the app bar when collapsed (must be larger than or equal to the toolbarHeight)
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 14, bottom: 24),
        // centerTitle: true,
        background: Container(
          color: const Color(0xff5E9EFE),
        ),
        title: LayoutBuilder(
          builder: (context, constraints) {
            constraints.maxWidth.log();
            constraints.maxHeight.log();
            return SizedBox(
              width: constraints.maxWidth * 0.80,
              height: 36,
              child: TextFormField(
                style: const TextStyle(
                    color: Colors.white, fontSize: 12, fontFamily: "Poppins"),
                cursorColor: Colors.white,
                cursorHeight: constraints.maxHeight * 0.08,
                enabled: true,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  fillColor: Colors.white,
                  hintText: "Looking for shoes",
                  hintStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff6A6A6A),
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color(0xff0D6EFD),
                  ),
                  focusColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.white,
                  )),
                ),
              ),
            );
          },
        ),
      ),
      centerTitle: true,
      title: const Text(
        'Explore',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: IconButton(
            onPressed: () {
              GoRouter.of(context).push("/cart");
            },
            icon: Icon(
              MdiIcons.cart,
            ),
          ),
        )
      ],
      leading: IconButton(
        icon: Icon(
          MdiIcons.menu,
          weight: 10,
          size: 35,
        ),
        onPressed: () {},
      ),
    );
  }
}
