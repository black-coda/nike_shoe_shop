import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/utils/formWidget.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // controller: controller,
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 29.0, vertical: 54),
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

                  //Email and Password Form Field
                  const FormInputWidget(),

                  //Recover password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      Text(
                        "Recover Password",
                        style: TextStyle(
                          color: Color(0xff707B81),
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FormInputWidget extends StatefulWidget {
  const FormInputWidget({super.key});

  @override
  State<FormInputWidget> createState() => _FormInputWidgetState();
}

class _FormInputWidgetState extends State<FormInputWidget> {
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
    return Column(
      children: [
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

        //Password
        const SizedBox(height: 30),
        DynamicInputWidget(
          labelText: "Password",
          controller: passwordController,
          focusNode: passwordFocusNode,
          isNonPasswordField: false,
          validator: authValidators.passwordWordValidator,
          obscureText: true,
          toggleObscureText: toggleObscureText,
          prefIcon: const Icon(MdiIcons.formTextboxPassword),
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
