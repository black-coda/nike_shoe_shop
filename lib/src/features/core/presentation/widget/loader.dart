import 'package:flutter/material.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    return Material(
      color: Colors.black.withAlpha(150),
      child: Center(
        child: Container(
          constraints: BoxConstraints(
            maxHeight: size.height * 0.65,
            maxWidth: size.width * 0.65,
            minWidth: size.width * 0.50,
          ),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10),
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text("Calm Down, it Loading ...")
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
