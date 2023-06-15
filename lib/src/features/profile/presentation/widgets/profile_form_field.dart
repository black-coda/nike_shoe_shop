import 'package:flutter/material.dart';

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
