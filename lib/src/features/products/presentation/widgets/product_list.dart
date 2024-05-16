import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/controllers/product_controller.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/widgets/product/product_grid.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';

// import 'app_bar.dart';
import 'app_bar.dart';
import 'header.dart';
import 'screen/custom_drawer.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key, this.onToggleAppBar});

  final VoidCallback? onToggleAppBar;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(productStateNotifier.notifier).getAllProduct();
  }

  @override
  Widget build(BuildContext context) {
    final productNotifier = ref.watch(productStateNotifier);
    final bool isLoading = ref.watch(productStateNotifier.notifier).isLoading;

    

    return Scaffold(
      backgroundColor: const Color(0xffF7F7F9),
      body: (isLoading || productNotifier.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff0D6EFD),
              ),
            )
          : CustomScrollView(
              slivers: [
                const CustomSliverAppBar(),
                const HeaderWidget(title: "Select Category"),

                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 0.0),
                          child: Chip(
                            label: const Text("Chip A"),
                            labelStyle: TextStyle(
                              color: index % 2 != 0
                                  ? const Color(0xff0D6EFD)
                                  : Colors.white,
                            ),
                            side: BorderSide.none,
                            backgroundColor: index % 2 != 0
                                ? Colors.white
                                : const Color(0xff0D6EFD),
                          ),
                        );
                      },
                      itemCount: 10,
                    ),
                  ),
                ),
                // //* Header
                const HeaderWidget(title: "Popular Shoes", isMore: true),

                //* product Card
                ProductGridView(provider: productStateNotifier),
                const HeaderWidget(title: "Popular Shoes", isMore: true),
                const SliverToBoxAdapter(child: SizedBox(height: 90)),
              ],
            ),
    );
  }
}

class DrawerStack extends ConsumerStatefulWidget {
  const DrawerStack({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DrawerStackState();
}

class DrawerStackState extends ConsumerState<DrawerStack>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  final double maxSlide = 255.0;
  final double minDragStartEdge = 94.0;
  final double maxDragStartEdge = 255.0;

  bool _canBeDragged = false;

  void toggle() {
    _animationController.isDismissed
        ? _animationController.forward()
        : _animationController.reverse();
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = _animationController.isDismissed &&
        details.globalPosition.dx < minDragStartEdge;
    bool isDragOpenFromRight = _animationController.isCompleted &&
        details.globalPosition.dx > maxDragStartEdge;

    _canBeDragged = isDragOpenFromLeft || isDragOpenFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / maxSlide;
      _animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    if (_animationController.isDismissed || _animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.sizeOf(context).width;
      _animationController.fling(velocity: visualVelocity);
    } else if (_animationController.value < 0.5) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        double slide = maxSlide * _animationController.value;
        slide.log();
        double scale = 1 - (_animationController.value * 0.4);
        return Stack(
          children: [
            const CustomDrawer(),
            Transform(
              transform: Matrix4.identity()
                ..translate(slide)
                ..scale(scale),
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onHorizontalDragStart: _onDragStart,
                onHorizontalDragUpdate: _onDragUpdate,
                onHorizontalDragEnd: _onDragEnd,
                child: ProductListScreen(
                  onToggleAppBar: toggle,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
