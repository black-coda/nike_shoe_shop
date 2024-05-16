import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nike_shoe_shop/src/features/products/presentation/widgets/product_list.dart';

import 'screen/custom_drawer.dart';

// class DrawerStack extends ConsumerStatefulWidget {
//   const DrawerStack({super.key});
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _DrawerStackState();
// }

// class _DrawerStackState extends ConsumerState<DrawerStack>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 250),
//     );
//   }

//   final double maxSlide = 255.0;
//   final double minDragStartEdge = 94.0;
//   final double maxDragStartEdge = 255.0;

//   bool _canBeDragged = false;

//   void toggle() {
//     _animationController.isDismissed
//         ? _animationController.forward()
//         : _animationController.reverse();
//   }

//   void _onDragStart(DragStartDetails details) {
//     bool isDragOpenFromLeft = _animationController.isDismissed &&
//         details.globalPosition.dx < minDragStartEdge;
//     bool isDragOpenFromRight = _animationController.isCompleted &&
//         details.globalPosition.dx > maxDragStartEdge;

//     _canBeDragged = isDragOpenFromLeft || isDragOpenFromRight;
//   }

//   void _onDragUpdate(DragUpdateDetails details) {
//     if (_canBeDragged) {
//       double delta = details.primaryDelta! / maxSlide;
//       _animationController.value += delta;
//     }
//   }

//   void _onDragEnd(DragEndDetails details) {
//     if (_animationController.isDismissed || _animationController.isCompleted) {
//       return;
//     }
//     if (details.velocity.pixelsPerSecond.dx.abs() >= 365.0) {
//       double visualVelocity = details.velocity.pixelsPerSecond.dx /
//           MediaQuery.sizeOf(context).width;
//       _animationController.fling(velocity: visualVelocity);
//     } else if (_animationController.value < 0.5) {
//       _animationController.reverse();
//     } else {
//       _animationController.forward();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animationController,
//       builder: (context, child) {
//         double slide = maxSlide * _animationController.value;
//         double scale = 1 - (_animationController.value * 0.3);
//         return Stack(
//           children: [
//             const CustomDrawer(),
//             Transform(
//               transform: Matrix4.identity()
//                 ..translate(slide)
//                 ..scale(scale),
//               alignment: Alignment.centerLeft,
//               child: GestureDetector(
//                 onHorizontalDragStart: _onDragStart,
//                 onHorizontalDragUpdate: _onDragUpdate,
//                 onHorizontalDragEnd: _onDragEnd,
//                 child: const ProductListScreen(),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }


