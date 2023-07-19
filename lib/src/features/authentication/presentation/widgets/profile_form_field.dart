import 'package:flutter/material.dart';
import 'package:nike_shoe_shop/src/utils/form_widget.dart';

class CustomProfileFormField extends StatelessWidget {
  const CustomProfileFormField({
    super.key,
    required this.fieldName,
    required this.fieldHintText,
    this.isPasswordField,
  });

  final String fieldName;
  final String fieldHintText;
  final bool? isPasswordField;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldName,
          style: const TextStyle(
              color: Color(0xff707B81), fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        TextFormField(
          obscureText: isPasswordField ?? true,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffF7F7F9),
            hintText: fieldHintText,
            enabled: false,
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.0,
                color: Color(0xffF7F7F9),
                style: BorderStyle.none,
                strokeAlign: 0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 0.0,
                color: Color(0xffF7F7F9),
                style: BorderStyle.none,
                strokeAlign: 0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
          ),
        )
      ],
    );
  }
}

class ProfileUpdateField extends StatefulWidget {
  const ProfileUpdateField({
    super.key,
    required this.fieldName,
    required this.fieldHintText,
    this.isPasswordField,
  });

  final String fieldName;
  final String fieldHintText;
  final bool? isPasswordField;

  @override
  State<ProfileUpdateField> createState() => _ProfileUpdateFieldState();
}

class _ProfileUpdateFieldState extends State<ProfileUpdateField> {
  final AuthValidators authValidators = AuthValidators();

  bool obscureText = true;

  // controllers

  late TextEditingController emailController;
  late TextEditingController passwordController;

  //* create focus nodes

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

    //* controller
    emailController.dispose();
    passwordController.dispose();

    //* Focus node
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        DynamicInputWidget(
          isNonPasswordField: true,
          enabled: false,
          controller: emailController,
          obscureText: obscureText,
          focusNode: emailFocusNode,
          prefIcon: const Icon(Icons.edit),
          labelText: "Password",
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
