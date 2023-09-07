import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/constant/konstant.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:nike_shoe_shop/src/features/core/presentation/widget/btn.dart';
// import 'package:nike_shoe_shop/src/utils/devtool.dart';

import 'profile_form_field.dart';

class UserProfileScreen extends ConsumerWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileDetail = ref.watch(authChangesFutureProvider);

    // Check if userProfileDetail has data and is not null

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
              data: (Map<String, dynamic>? data) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    CircleAvatar(
                      maxRadius: 45,
                      backgroundImage: NetworkImage(
                        data?["photoUrl"] ?? AuthKonstant.defaultPhoto,
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
                            fieldHintText: data?["displayName"] ?? "",
                          ),
                          const SizedBox(height: 10),
                          CustomProfileFormField(
                              fieldName: "Email Address",
                              fieldHintText: data?["email"]),
                          const SizedBox(height: 10),
                          const CustomProfileFormField(
                              fieldName: "Password",
                              fieldHintText: "*****************"),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 40,
                            child: const mainBtn(
                              location: "/profile/editProfile",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
              loading: () {
                return Center(
                  child: LottieBuilder.asset(
                    "assets/lottie/97204-loader.json",
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
