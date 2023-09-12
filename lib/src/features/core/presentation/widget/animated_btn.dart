import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AnimatedIconButton extends StatefulWidget {
  const AnimatedIconButton(
      {super.key, required this.mdiIcons, required this.onTapped});

  final Widget mdiIcons;
  final VoidCallback onTapped;

  @override
  _AnimatedIconButtonState createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isClicked = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animation = Tween<double>(begin: 1.0, end: 0.4).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          setState(() {
            _isClicked = false;
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onButtonClicked() async {
    widget.onTapped();
    if (!_isClicked) {
      setState(() {
        _isClicked = true;
      });
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onButtonClicked(),
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: child,
          );
        },
        child: widget.mdiIcons,
      ),
    );
  }
}
