import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
      ),
      body: Center(
        child: Form(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                  "https://images.pexels.com/photos/5876695/pexels-photo-5876695.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Your Name",
                      style: TextStyle(
                          color: Color(0xff707B81),
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xffF7F7F9),
                        hintText: "Solomon Monday",
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.0,
                            color: Color(0xffF7F7F9),
                            style: BorderStyle.none,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(14)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
