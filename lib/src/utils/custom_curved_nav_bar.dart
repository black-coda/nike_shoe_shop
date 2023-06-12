import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomCurvedNavigationBar extends StatelessWidget {
  const CustomCurvedNavigationBar({super.key});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      // color: Colors.red,
      height: 80,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 80,
              child: Stack(
                children: [
                  CustomPaint(
                    painter: _CurvedPainter(),
                    size: Size(
                      size.width,
                      80,
                    ),
                  ),

                  //? floating action button

                  Center(
                    heightFactor: .0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(180)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.4),
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: FloatingActionButton(
                        backgroundColor: const Color(0xff0D6EFD),
                        elevation: 2.0,
                        onPressed: () {},
                        shape: const CircleBorder(),
                        child: const Icon(
                          MdiIcons.cartOutline,
                        ),
                      ),
                    ),
                  ),

                  //? icons

                  SizedBox(
                    height: 90,
                    // width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(MdiIcons.homeOutline),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(MdiIcons.heartOutline),
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: size.width * 0.20,
                        ),
                        IconButton(
                          icon: const Icon(MdiIcons.bellOutline),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(MdiIcons.accountOutline),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomCurvedNavigationWidget extends ConsumerWidget {
  const CustomCurvedNavigationWidget(
      {super.key,
      required this.items,
      required this.onTap,
      this.selectedColor = const Color(0xff0D6EFD),
      this.unselectedColor = Colors.black,
      this.currentIndex = 0})
      : assert(
          items.length == 4,
          'The correct functioning of this widgets '
          'depends on its items being exactly 4',
        );

  final List<CurvedNavigationBarItem> items;
  final ValueChanged<int>? onTap;
  // final int Function() onTap;
  final Color unselectedColor;
  final Color selectedColor;
  final int currentIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      // color: Colors.red,
      height: 80,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 70,
              child: Stack(
                children: [
                  CustomPaint(
                    painter: _CurvedPainter(),
                    size: Size(
                      size.width,
                      80,
                    ),
                  ),

                  //? floating action button

                  Center(
                    heightFactor: .0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(180)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.4),
                            blurRadius: 3,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: FloatingActionButton(
                        backgroundColor: const Color(0xff0D6EFD),
                        elevation: 2.0,
                        onPressed: () {},
                        shape: const CircleBorder(),
                        child: const Icon(
                          MdiIcons.cartOutline,
                        ),
                      ),
                    ),
                  ),

                  //? icons

                  SizedBox(
                    height: 90,
                    // width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(items.length, (index) {
                        final item = items[index];
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: (index == 0 || index == 3) ? 20.0 : 0,
                          ),
                          child: IconButton(
                            onPressed: () => onTap?.call(index),
                            color: index == currentIndex
                                ? selectedColor
                                : unselectedColor,
                            icon: Icon(
                              index == currentIndex
                                  ? item.selectedIconData ?? item.iconData
                                  : item.iconData,
                            ),
                          ),
                        );
                      })
                        ..insert(2, SizedBox(width: size.width * 0.20)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//? Curved Navigation Bar Item

class CurvedNavigationBarItem {
  final IconData iconData;
  final IconData? selectedIconData;

  CurvedNavigationBarItem({required this.iconData, this.selectedIconData});
}

//? NavBar Clipper

class _CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, -30); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: const Radius.elliptical(6, 4), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, -30);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, -30);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
