import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/user_model.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/auth_form_input.dart';
import 'package:nike_shoe_shop/src/features/authentication/utils/provider.dart';
import 'package:nike_shoe_shop/src/utils/form_widget.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();

  final AuthValidators authValidators = AuthValidators();

  bool obscureText = false;

  // controllers

  late TextEditingController emailController;
  late TextEditingController passwordController;

// create focus nodes

  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();

    passwordController = TextEditingController();

    emailFocusNode = FocusNode();

    passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();

    // controller
    emailController.dispose();
    passwordController.dispose();

    // Focus node
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  void toggleObscureText() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // controller: controller,
          child: Form(
            key: _formKey,
            child: Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 29.0, vertical: 78),
                child: Column(
                  children: [
                    const Text(
                      "Hello Again",
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
                    const LoginFormInputWidget(),

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

                    //? Sign in with email/password Button

                    SizedBox(
                      width: MediaQuery.of(context).size.width - 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          final emailText = emailController.text.trim();

                          final passwordText = passwordController.text.trim();

                          final UserModel userModel = UserModel(
                              email: emailText,
                              password: passwordText,
                              displayName: '');
                          await ref
                              .read(authStateNotifierProvider.notifier)
                              .loginUserWithEmailAndPassword(userModel);
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
                    //? Create new account

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "New User? ",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff6A6A6A),
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.go("/register"),
                          child: const Text(
                            "Create Account",
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
