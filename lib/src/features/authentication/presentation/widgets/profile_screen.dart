import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/profile_controllers.dart';

import 'profile_form_field.dart';

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
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            child: Column(
              children: [
                const SizedBox(
                  height: 18,
                ),
                const CircleAvatar(
                  maxRadius: 45,
                  backgroundImage: NetworkImage(
                    "https://images.pexels.com/photos/5876695/pexels-photo-5876695.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      final profileDetails =
                          ref.watch(displayNameFutureProvider);

                      return profileDetails.when(
                        data: (data) {
                          debugPrint(data);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomProfileFormField(
                                  fieldName: "Your Name", fieldHintText: data),
                              const SizedBox(height: 10),
                              const CustomProfileFormField(
                                  fieldName: "Email Address",
                                  fieldHintText: "mondaysolomon01@gmail.com"),
                              const SizedBox(height: 10),
                              const CustomProfileFormField(
                                  fieldName: "Password",
                                  fieldHintText: "********"),
                              const SizedBox(height: 15),
                              SizedBox(
                                width: MediaQuery.of(context).size.width - 40,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(18),
                                    backgroundColor: const Color(0xff0D6EFD),
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(14))),
                                  ),
                                  child: Text(
                                    "Edit Profile",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(
                                            color: const Color(0xffF7F7F9)),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        error: (Object error, StackTrace stackTrace) {
                          return Text("Error: $error");
                        },
                        loading: () {
                          return Center(
                            child: LottieBuilder.asset(
                                "assets/lottie/97204-loader.json"),
                          );
                        },
                      );
                    },
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
