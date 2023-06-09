import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nike_shoe_shop/src/features/authentication/presentation/controller/auth_controller.dart';
import 'package:nike_shoe_shop/src/utils/form_widget.dart';

class PasswordResetWidget extends ConsumerStatefulWidget {
  const PasswordResetWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PasswordResetWidgetState();
}

class _PasswordResetWidgetState extends ConsumerState<PasswordResetWidget> {
  final _formKey = GlobalKey<FormState>();
  final AuthValidators authValidators = AuthValidators();
  late TextEditingController emailController;
  late FocusNode emailFocusNode;

  @override
  void initState() {
    super.initState();
    //? Controller
    emailController = TextEditingController();
    //? Focus
    emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    emailFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = ref.watch(authStateNotifierProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Forgot Password ?",
          style: TextStyle(
            color: Color(0xff2B2B2B),
            fontWeight: FontWeight.w900,
            fontSize: 30,
            fontFamily: 'RaleWay',
          ),
          textAlign: TextAlign.center,
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: GestureDetector(
            onTap: () => context.go("/login"),
            child: const CircleAvatar(
              radius: 2,
              backgroundColor: Color(0xffF7F7F9),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 15,
                color: Color(0xff2B2B2B),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 29.0, vertical: 29),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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

                //? Input Field

                DynamicInputWidget(
                  labelText: "Enter Your Email Address",
                  isNonPasswordField: true,
                  controller: emailController,
                  obscureText: true,
                  focusNode: emailFocusNode,
                  prefIcon: const Icon(MdiIcons.email),
                  textInputAction: TextInputAction.done,
                  validator: authValidators.emailValidator,
                ),

                const SizedBox(
                  height: 56,
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final email = emailController.text.trim();
                        await authProvider.sendPasswordResetEmail(
                            email, context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(18),
                      backgroundColor: const Color(0xff0D6EFD),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
