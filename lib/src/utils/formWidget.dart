import 'package:flutter/material.dart';

class DynamicInputWidget extends StatelessWidget {
  const DynamicInputWidget(
      {super.key,
      required this.isNonPasswordField,
      required this.controller,
      this.toggleObscureText,
      required this.obscureText,
      required this.focusNode,
      this.validator,
      required this.prefIcon,
      required this.labelText,
      required this.textInputAction});

  // bool to check if the text field is for password or not
  final bool isNonPasswordField;
  // Controller for the text field
  final TextEditingController controller;
  // Function to toggle Text obscuration on the password text field
  final VoidCallback? toggleObscureText;
  // to obscure text or not bool
  final bool obscureText;
  // FocusNode for input
  final FocusNode focusNode;
  // Validator function
  final String? Function(String?)? validator;
  // Prefix icon for input form
  final Icon prefIcon;
  // label for input form
  final String labelText;
  // The keyword action to display
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      
      controller: controller,
      decoration: InputDecoration(
        
        border: const OutlineInputBorder(
            // Make border edge circular
            borderRadius: BorderRadius.all(Radius.circular(14.0)),
            borderSide: BorderSide(color: Color(0xff0D6EFD))),
        label: Text(labelText),
        fillColor: const Color(0xff0D6EFD),
        iconColor: const Color(0xff0D6EFD),
        prefixIconColor: const Color(0xff0D6EFD),
        prefixIcon: prefIcon,
        suffixIcon: IconButton(
          onPressed: toggleObscureText,
          icon: isNonPasswordField
              ? const Icon(null)
              : obscureText
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off),
        ),
      ),
      focusNode: focusNode,
      textInputAction: textInputAction,
      obscureText: obscureText,
      validator: validator,
      // onSaved: passwordValidator,
    );
  }
}

class AuthValidators {
  static const String emailErrMsg =
      "Invalid Email Address, Please provide a valid email.";
  static const String passwordErrMsg =
      "Password must have at least 6 characters.";
  static const String confirmPasswordErrMsg = "Two passwords don't match.";
  static const usernameErrMsg = "Username cannot character used";

  String? emailValidator(String? val) {
    final String email = val as String;

    RegExp emailReg = RegExp(email);

    bool containsSpecialCharacters(String str) {
      final pattern = RegExp(r'[!^&%#()$*]');
      return pattern.hasMatch(str);
    }

    //Check if the length of the email is less than or equal to 3

    if (email.length <= 3) return emailErrMsg;

    if (containsSpecialCharacters(email)) return emailErrMsg;

    // Check if it has @
    // # 4
    final hasAtSymbol = email.contains('@');

    // find the position of @
    // # 5
    final indexOfAt = email.indexOf('@');

    // Check numbers of @
    // # 6
    final numbersOfAt = "@".allMatches(email).length;

    // Valid if has @
    if (!hasAtSymbol) return emailErrMsg;
    // and  if the number of @ is only 1
    if (numbersOfAt != 1) return emailErrMsg;
    //and if  '@' is not the first or last character
    if (indexOfAt == 0 || indexOfAt == email.length - 1) return emailErrMsg;

    //if it contains value such as #$%!^@&_-

    // Else its valid
    return null;
  }

  // Password validator

  String? passwordWordValidator(String? val) {
    final String password = val as String;

    if (password.isEmpty || password.length <= 5) return passwordErrMsg;

    // else
    return null;
  }

  // confirm password

  String? confirmPasswordValidator(String? val1, String? val2) {
    final String password1 = val1 as String;
    final String password2 = val2 as String;

    if (password1.isEmpty ||
        password2.isEmpty ||
        password1.length != password2.length) return confirmPasswordErrMsg;

    //  If two passwords do not match then send an error message

    if (password1 != password2) return confirmPasswordErrMsg;

    return null;
  }

  String? usernameValidator(String? val) {
    final String username = val as String;

    bool containsSpecialCharacters(String str) {
      final pattern = RegExp(r'[!^&%#()$*]');
      return pattern.hasMatch(str);
    }

    if (containsSpecialCharacters(username)) return usernameErrMsg;
    // else
    return null;
  }
}
