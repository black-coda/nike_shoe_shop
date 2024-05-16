import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).primaryColor,
      width: MediaQuery.sizeOf(context).width,
      child: const Column(
        children: [
          DrawerHeader(
            child: ListTile(
              leading: CircleAvatar(
                child: FlutterLogo(),
              ),
              title: Text(
                "Monday Solomon",
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
