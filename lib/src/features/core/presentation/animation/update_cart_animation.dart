import 'package:flutter/material.dart';

class UpdateCartAnimation extends StatefulWidget {
  final int itemCount;
  final Duration duration;

  const UpdateCartAnimation({
    Key? key,
    required this.itemCount,
    this.duration = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  _UpdateCartAnimationState createState() => _UpdateCartAnimationState();
}

class _UpdateCartAnimationState extends State<UpdateCartAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant UpdateCartAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.itemCount != oldWidget.itemCount) {
      _controller.reset();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: 1 + (_animation.value * 0.2),
          child: child,
        );
      },
      child: const Icon(
        Icons.shopping_cart,
        color: Colors.blue,
        size: 24,
      ),
    );
  }
}
