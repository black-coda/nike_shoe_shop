import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';

class ProductListScreen extends ConsumerWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
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
                        color: Colors.white,
                        fontSize: 12,
                        fontFamily: "Poppins"),
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
              child: CircleAvatar(
                backgroundColor: const Color(0xffD7E7FF),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    MdiIcons.cart,
                  ),
                ),
              ),
            )
          ],
          leading: IconButton(
            icon: const Icon(
              MdiIcons.menu,
              color: Color(0xff0D6EFD),
              weight: 10,
              size: 35,
            ),
            onPressed: () {},
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                color: index.isOdd ? Colors.yellow : Colors.black12,
                height: 100.0,
                child: Center(
                  child: Text('$index', textScaleFactor: 5),
                ),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        constraints.maxWidth.log();
        constraints.maxHeight.log();
        return SizedBox(
          width: constraints.maxWidth * 0.65,
          height: constraints.maxHeight * 0.40,
          child: TextFormField(
            style: const TextStyle(
                color: Colors.white, fontSize: 12, fontFamily: "Poppins"),
            cursorColor: Colors.white,
            cursorHeight: constraints.maxHeight * 0.08,
            enabled: true,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
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
    );
  }
}
