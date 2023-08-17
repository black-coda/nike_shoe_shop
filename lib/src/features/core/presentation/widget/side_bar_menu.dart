import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/custom_divider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final widthOfScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: 0.75 * widthOfScreen,
        color: const Color(0xff1483C2),
        child: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundImage: NetworkImage(
                      "https://images.pexels.com/photos/5876695/pexels-photo-5876695.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                ),
                SizedBox(height: 25),
                Text(
                  "Monday Solomon O",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                CustomDivider(),
                Text(
                  "Profile",
                  style: TextStyle(
                    color: Color(0xffDBDBDB),
                    fontSize: 18,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
