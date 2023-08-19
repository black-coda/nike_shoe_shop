import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LeadReturnBtn extends StatelessWidget {
  const LeadReturnBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: IconButton(
        icon: const Icon(Icons.arrow_back_ios, size: 20),
        onPressed: () {
          GoRouter.of(context).pop();
        },
      ),
    );
  }
}

class mainBtn extends StatelessWidget {
  const mainBtn({
    super.key,
    required this.location,
  });

  final String location;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        GoRouter.of(context).push(location);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(18),
        backgroundColor: const Color(0xff0D6EFD),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14))),
      ),
      child: Text(
        "Edit Profile",
        style: Theme.of(context)
            .textTheme
            .labelMedium
            ?.copyWith(color: const Color(0xffF7F7F9)),
      ),
    );
  }
}


class OnBoardBtn extends StatelessWidget {
  const OnBoardBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        return context.go("/login");
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(18),
        backgroundColor: const Color(0xffECECEC),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14))),
      ),
      child: Text(
        "Get Started",
        style: Theme.of(context).textTheme.labelMedium,
      ),
    );
  }
}

