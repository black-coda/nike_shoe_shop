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
              OnBoardScreen1(),
              OnBoardScreen2(),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            alignment: const Alignment(0, 0.72),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {
                    _controller.previousPage(
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeIn);
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
                        curve: Curves.easeIn);
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
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage("assets/svg/Vector(1).png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: const Color(0xFF1483C2),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/others/shoe2.png",
                    fit: BoxFit.contain,
                  ),
                  Text(
                    "You Have The Power To Step into a world of endless possibilities",
                    style: Theme.of(context).textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  const Text(
                    "There Are Many Beautiful And Attractive Plants To Your Room",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 16,
                      color: Color(0xFFD8D8D8),
                    ),
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

class OnBoardScreen2 extends StatefulWidget {
  const OnBoardScreen2({super.key});

  @override
  State<OnBoardScreen2> createState() => _OnBoardScreen2State();
}

class _OnBoardScreen2State extends State<OnBoardScreen2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        color: Colors.transparent,
        image: DecorationImage(
          image: AssetImage("assets/svg/Vector(1).png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF1483C2),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 30),
                    Image.asset("assets/images/others/shoe_.png"),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      "Let's Start Journey\nWith Nike",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffECECEC),
                        fontWeight: FontWeight.w900,
                        fontSize: 34,
                        fontFamily: 'RaleWay',
                      ),
                    ),
                    const SizedBox(
                      height: 19,
                    ),
                    const Text(
                      "Smart, Gorgeous & Fashionable Collection\nExplore Now",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 16,
                        color: Color(0xFFD8D8D8),
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: const Alignment(0, 0.94),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(18),
                        backgroundColor: const Color(0xffECECEC),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(14))),
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
      ),
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
