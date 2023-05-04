import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/utils/formWidget.dart';

class LoginFormInputWidget extends StatefulWidget {
  const LoginFormInputWidget({super.key});

  @override
  State<LoginFormInputWidget> createState() => _LoginFormInputWidgetState();
}

class _LoginFormInputWidgetState extends State<LoginFormInputWidget> {
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
      ],
    );
  }
}

class RegFormInputWidget extends StatefulWidget {
  const RegFormInputWidget({super.key});

  @override
  State<RegFormInputWidget> createState() => _RegFormInputWidgetState();
}

class _RegFormInputWidgetState extends State<RegFormInputWidget> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //? fullname
        DynamicInputWidget(
          labelText: "Your Name",
          controller: fullNameController,
          focusNode: fullNameNode,
          isNonPasswordField: true,
          obscureText: obscureText,
          toggleObscureText: toggleObscureText,
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

        //Password
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
      ],
    );
  }
}
