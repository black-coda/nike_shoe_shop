import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/profile_controllers.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/widgets/edit_profile.dart';

import 'profile_form_field.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileDetail = ref.watch(userProfileProvider);

    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            child: const Icon(MdiIcons.logout),
            onTap: () async {
              await ref.read(authStateNotifierProvider.notifier).logoutUser();
            },
          ),
          const SizedBox(width: 30),
        ],
        centerTitle: true,
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            child: userProfileDetail.when(
              data: (List<UserInfo>? data) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    CircleAvatar(
                      maxRadius: 45,
                      backgroundImage: NetworkImage(
                        data?[0].photoURL ??
                            "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png",
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomProfileFormField(
                              fieldName: "Your Name",
                              fieldHintText:
                                  data?[0].displayName ?? "Anonymous"),
                          const SizedBox(height: 10),
                          CustomProfileFormField(
                              fieldName: "Email Address",
                              fieldHintText:
                                  data?[0].email ?? "anonymous@mail.com"),
                          const SizedBox(height: 10),
                          const CustomProfileFormField(
                              fieldName: "Password", fieldHintText: "********"),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(18),
                                backgroundColor: const Color(0xff0D6EFD),
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(14))),
                              ),
                              child: InkWell(
                                onTap: () {
                                  // TODO: Continue from here
                                  GoRouter.of(context).push("/edit");
                                  // context.go("/profile/edit");
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return const UpdateProfile();
                                  }));
                                },
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
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              loading: () {
                return Dialog(
                  backgroundColor: Colors.white,
                  child: Container(
                    height: 350,
                    child: Center(
                      child:
                          LottieBuilder.asset("assets/lottie/97204-loader.json"),
                    ),
                  ),
                );
              },
              error: (Object error, StackTrace stackTrace) {
                return Center(
                  child: Text("Error: $error"),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
