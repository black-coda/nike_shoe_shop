import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';

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

  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            children: const [
              OnBoardScreen3(),
              OnBoardScreen2(),
              OnBoardScreen1(),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            alignment: const Alignment(0, 0.65),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    _controller.previousPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.bounceInOut);
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const ExpandingDotsEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      activeDotColor: Color(0xFFF87265),
                      dotColor: Color(0xffECECEC),
                    )),
                TextButton(
                  onPressed: () {
                    _controller.nextPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.bounceInOut);
                  },
                  child: const Text(
                    "Next",
                    style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          )
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
      body: SafeArea(child: Column()),
    );
  }
}

class OnBoardScreen2 extends StatefulWidget {
  const OnBoardScreen2({super.key});

  @override
  State<OnBoardScreen2> createState() => _OnBoardScreen2State();
}

class _OnBoardScreen2State extends State<OnBoardScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1483C2),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [],
      )),
    );
  }
}

class OnBoardScreen3 extends StatelessWidget {
  const OnBoardScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1483C2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 35),
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: [
              SvgPicture.asset(
                "assets/images/bckgrnd.svg",
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SvgPicture.asset("assets/svg/welcome.svg"),
                ],
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Image.asset(
                  "assets/images/splash/shoe_splash.png",
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(18),
                      backgroundColor: const Color(0xffECECEC),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(14))),
                    ),
                    child: Text(
                      "Get Started",
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
