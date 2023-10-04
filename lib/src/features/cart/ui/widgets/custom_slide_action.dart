import 'package:flutter/material.dart';

//! Still not working
class CustomSlideAction extends StatelessWidget {
  final int initialItemCount;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData addIcon;
  final IconData removeIcon;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const CustomSlideAction({
    Key? key,
    required this.initialItemCount,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.addIcon,
    required this.removeIcon,
    required this.onIncrease,
    required this.onDecrease,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                addIcon,
                size: 15,
              ),
              onPressed: () => onIncrease(),
              color: foregroundColor,
            ),
            Text(
              initialItemCount.toString(),
              style: TextStyle(
                color: foregroundColor,
                fontSize: 10.0,
              ),
            ),
            IconButton(
              icon: Icon(
                removeIcon,
                size: 15,
              ),
              onPressed: () => onDecrease(),
              color: foregroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
