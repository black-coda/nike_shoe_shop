import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<void> loadData() async {
  // Load data here
  await Future.delayed(const Duration(seconds: 3));
}

class OnBoardScreen extends StatefulWidget {
  const OnBoardScreen({super.key});

  @override
  State<OnBoardScreen> createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  @override
  void initState() {
    super.initState();
    loadData().then((_) {
      // Remove the splash screen after data has been loaded
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const [
          OnBoardScreen1(),
          OnBoardScreen2(),
          OnBoardScreen3(),
        ],
      ),
    );
  }
}

class OnBoardScreen1 extends StatefulWidget {
  const OnBoardScreen1({super.key});

  @override
  State<OnBoardScreen1> createState() => _OnBoardScreen1State();
}

class _OnBoardScreen1State extends State<OnBoardScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1483C2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Align(
                            alignment: const Alignment(-0.8, -1),
                            child: SvgPicture.asset("assets/svg/highlight.svg"),
                          ),
                          Text(
                            "Welcome to Nike".toUpperCase(),
                            style: Theme.of(context).textTheme.headlineLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 19),
                  SvgPicture.asset("assets/svg/vector.svg"),
                  const SizedBox(height: 20),
                  Image.asset(
                    "assets/images/splash/shoe_splash.png",
                    scale: 1.4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OnBoardScreen2 extends StatelessWidget {
  const OnBoardScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        color: Color(0xFF1483C2),
        image: DecorationImage(
          image: AssetImage("assets/images/bckgrnd.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class OnBoardScreen3 extends StatelessWidget {
  const OnBoardScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueGrey,
    );
  }
}
