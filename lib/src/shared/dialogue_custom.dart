import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/auth_failure.dart';

//TODO: Continue from here
Future<Object?> customDialog(context, {AuthFailure? failure, Unit? success}) {
  return showGeneralDialog(
    context: context,
    barrierLabel: "warning",
    barrierDismissible: true,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 30),
              blurRadius: 60,
            ),
            const BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 30),
              blurRadius: 60,
            ),
          ],
        ),
        child: const Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              
            ],
          ),
        ),
      );
    },
  );
}
