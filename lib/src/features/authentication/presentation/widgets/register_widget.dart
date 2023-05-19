import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/user_model.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/provider.dart';
import 'package:nike_shoe_shop/src/utils/form_widget.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  final AuthValidators authValidators = AuthValidators();

  bool obscureText = false;

  // controllers
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

// create focus nodes
  late FocusNode fullNameNode;
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();

    fullNameController = TextEditingController();

    emailController = TextEditingController();

    passwordController = TextEditingController();
    fullNameNode = FocusNode();
    emailFocusNode = FocusNode();

    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    // controller
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();

    // Focus node
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    fullNameNode.dispose();
  }

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  // Register


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // controller: controller,
          physics: const NeverScrollableScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 29.0, vertical: 43),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            MdiIcons.arrowLeftDropCircleOutline,
                            color: Color(0xff6A6A6A),
                          ),
                          onPressed: () => context.go("/login"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Register Account",
                      style: TextStyle(
                        color: Color(0xff2B2B2B),
                        fontWeight: FontWeight.w900,
                        fontSize: 32,
                        fontFamily: 'RaleWay',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Fill your details or continue with\nsocial media",
                      style: TextStyle(
                        color: Color(0xff707B81),
                        fontWeight: FontWeight.normal,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),

                    //? Email and Password Form Field
                    //? fullName
                    DynamicInputWidget(
                      labelText: "Your Name",
                      controller: fullNameController,
                      focusNode: fullNameNode,
                      isNonPasswordField: true,
                      obscureText: false,
                      prefIcon: const Icon(MdiIcons.accountTie),
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 35),
                    // Email
                    DynamicInputWidget(
                      labelText: "Email Address",
                      controller: emailController,
                      focusNode: emailFocusNode,
                      isNonPasswordField: true,
                      obscureText: false,
                      prefIcon: const Icon(MdiIcons.email),
                      textInputAction: TextInputAction.next,
                    ),

                    //?Password
                    const SizedBox(height: 35),
                    DynamicInputWidget(
                      labelText: "Password",
                      controller: passwordController,
                      focusNode: passwordFocusNode,
                      isNonPasswordField: false,
                      validator: authValidators.passwordWordValidator,
                      obscureText: obscureText,
                      toggleObscureText: toggleObscureText,
                      prefIcon: const Icon(MdiIcons.formTextboxPassword),
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 35),

                    const SizedBox(height: 12),
                    //? Recover password
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Recover Password",
                          style: TextStyle(
                            color: Color(0xff707B81),
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 36,
                    ),

                    //? Register with email/password Button

                    SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      child: ElevatedButton(
                        onPressed: () async {

                          if (_formKey.currentState!.validate()) {
                             final emailText = emailController.text.trim();
                            final nameText = fullNameController.text.trim();
                            final passwordText = passwordController.text.trim();

                            final UserModel userModel = UserModel(
                                displayName: nameText,
                                email: emailText,
                                password: passwordText);
                            await ref
                                .read(authStateNotifierProvider.notifier)
                                .createUserWithEmailAndPassword(userModel);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(18),
                          backgroundColor: const Color(0xff0D6EFD),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                        ),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            color: Color(0xffFFFFFF),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    //? Sign in with Google Button
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      child: IconButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(18),
                          backgroundColor: const Color(0xffF7F7F9),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(14))),
                        ),
                        icon: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/svg/google_icon.svg"),
                            const SizedBox(width: 15),
                            const Text(
                              "Sign In with Google",
                              style: TextStyle(
                                color: Color(0xff2B2B2B),
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 55,
                    ),

                    //? Login to account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already Have an account?, ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff6A6A6A),
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.go("/login"),
                          child: const Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff1A1D1E),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
