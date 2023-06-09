import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xffc44a85),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                context.go("/test");
              },
              child: Text(
                "Redirect",
                style: TextStyle(
                  color: Colors.amber[900],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HomiePae extends StatefulWidget {
  const HomiePae({super.key});

  @override
  State<HomiePae> createState() => _HomiePaeState();
}

class _HomiePaeState extends State<HomiePae> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xffF7F7F9),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffffffff),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(MdiIcons.menu),
            Text("Explore"),
            Icon(MdiIcons.cart),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
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
                    painter: BNBCustomPainter(),
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
                    width: size.width,
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
          Align(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 21.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(MdiIcons.searchWeb),
                      labelText: "Looking for shoes",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

// class BNBcustomPainter extends CustomPj

class BNBCustomPainter extends CustomPainter {
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
