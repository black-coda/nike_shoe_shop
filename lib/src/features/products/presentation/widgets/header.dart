import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final bool isMore;

  const HeaderWidget({
    super.key,
    required this.title,
    this.isMore = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              isMore ? "See all" : "",
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Color(0xff0D6EFD),
              ),
            )
          ],
        ),
      ),
    );
  }
}
