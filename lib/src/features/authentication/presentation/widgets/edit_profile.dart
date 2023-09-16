import 'package:nike_shoe_shop/src/features/core/presentation/widget/btn.dart';
import 'package:nike_shoe_shop/src/utils/devtool.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:nike_shoe_shop/src/constant/konstant.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/widgets/profile_form_field.dart';
import 'package:nike_shoe_shop/src/utils/form_widget.dart';

class UpdateProfile extends ConsumerWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProfileDetail = ref.watch(userProfileProvider);

    final data = userProfileDetail.value;
    final emailData = data?["email"] ?? "";
    final displayName = data?["displayName"] ?? "";

    final GlobalKey<FormState> formKey =
        GlobalKey<FormState>(debugLabel: "editProfile:");
    //* textControllers

    final TextEditingController emailController =
        TextEditingController(text: emailData);
    final TextEditingController displayNameController =
        TextEditingController(text: displayName);

    //* FocusNode
    final FocusNode emailFocusNode = FocusNode();
    final FocusNode displayNameFocusNode = FocusNode();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Color(0xFF2B2B2B),
            fontSize: 20,
            fontFamily: 'RaleWay',
            fontWeight: FontWeight.w600,
            height: 20,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              if (formKey.currentState!.validate()) {
                if (emailController.text.trim().isNotEmpty &&
                    displayNameController.text.trim().isNotEmpty) {
                  await ref
                      .read(authStateNotifierProvider.notifier)
                      .updateUserProfile(
                        newDisplayName: displayNameController.text.trim(),
                        newEmail: emailController.text.trim(),
                        context: context,
                      );

                }
              }
            },
            child: const Text(
              'Done',
              textAlign: TextAlign.right,
              style: TextStyle(
                color: Color(0xFF0D6EFD),
                fontSize: 15,
                fontFamily: 'RaleWay',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 15),
        ],
        leading: const LeadReturnBtn(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: formKey,
              child: userProfileDetail.when(
                data: (Map<String, dynamic>? data) {
                  data?.log();
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
                      //* Display Name
                      Text(
                        data?["displayName"] ?? "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF2B2B2B),
                          fontSize: 20,
                          fontFamily: 'RaleWay',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          //TODO: Change profile picture functionality
                        },
                        child: const Text(
                          'Change Profile Picture',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFF0D6EFD),
                            fontSize: 12,
                            fontFamily: 'RaleWay',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //* display Name field
                            DynamicInputWidget(
                              controller: displayNameController,
                              focusNode: displayNameFocusNode,
                              isNonPasswordField: true,
                              obscureText: false,
                              prefIcon: const Icon(Icons.person),
                              labelText: 'Name',
                              textInputAction: TextInputAction.next,
                            ),
                            const SizedBox(height: 10),

                            //*  email field
                            DynamicInputWidget(
                              controller: emailController,
                              focusNode: emailFocusNode,
                              isNonPasswordField: true,
                              obscureText: false,
                              prefIcon: const Icon(Icons.mail_lock),
                              labelText: 'Email',
                              textInputAction: TextInputAction.done,
                            ),

                            const SizedBox(height: 10),
                            const ProfileUpdateField(
                                fieldName: "Password",
                                fieldHintText: "*****************"),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  );
                },
                loading: () {
                  return Dialog(
                    backgroundColor: Colors.white,
                    child: Center(
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        height: 100,
                        width: 100,
                        child: Center(
                          child: LottieBuilder.asset(
                              "assets/lottie/97204-loader.json"),
                        ),
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
      ),
    );
  }
}


