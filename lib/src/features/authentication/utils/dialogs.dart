import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nike_shoe_shop/src/features/authentication/domain/auth_failure.dart';

class DialogScreen{
  //? Loader Dialog Screen
  static Future<dynamic> loaderDialog(context) {
    return showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
              child: Text("Logging In",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 150,
                width: 150,
                child: Lottie.asset("assets/lottie/97204-loader.json"),
              ),
              const SizedBox(height: 16),
              const Text("Please wait...",
                  style: TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
        );
      },
    );
  }


  //? Error Dialog Screen

  static Future<dynamic> errorDialog(context, AuthFailure failCase) {
    return showDialog(
      context: context,
      barrierDismissible:
          true, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
              child: Text(
            "Oops 😭, ${failCase.message}!",
            style: const TextStyle(
              color: Color(0xffe3342f),
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset("assets/lottie/41791-loading-wrong.json"),
              const SizedBox(height: 16),
              const Text("Try again !!!")
            ],
          ),
        );
      },
    );
  }




  //? Success Dialogue Screen
  //! This really display to the user

  static Future<dynamic> successDialog(context, Unit success) {
    return showDialog(
      context: context,
      barrierDismissible:
          true, // Prevent dismissing the dialog by tapping outside
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text(success.toString())),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset("assets/lottie/41793-correct.json"),
              const SizedBox(height: 16),
              const Text("Please wait..."),
            ],
          ),
        );
      },
    );
  }
}