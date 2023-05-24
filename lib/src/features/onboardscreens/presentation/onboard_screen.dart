import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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

  //? Check if last page
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                if (index == 2) {
                  isLastPage = true;
                }
              });
            },
            children: const [
              PageView1(),
              PageView2(),
              PageView3(),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15),
            alignment: const Alignment(0, 0.72),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //* Skip Button
                TextButton(
                  onPressed: () {
                    _controller.jumpToPage(2);
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
                  ),
                ),

                //? Next and Done Button
                isLastPage
                    ? TextButton(
                        onPressed: () => context.go("/login"),
                        child: const Text(
                          "Continue",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    : TextButton(
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
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PageView2 extends StatelessWidget {
  const PageView2({super.key});

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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 360,
                    child: Image.asset(
                      "assets/images/others/shoe2.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text(
                    "You Have The Power To Step into a world of endless possibilities",
                    style: TextStyle(
                      color: Color(0xffECECEC),
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      fontFamily: 'RaleWay',
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 45,
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

class PageView3 extends StatelessWidget {
  const PageView3({super.key});

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

                //* Button Redirect to Login page
                Align(
                  alignment: const Alignment(0, 0.94),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: ElevatedButton(
                      onPressed: ()async => context.go('/login'),
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

class PageView1 extends StatelessWidget {
  const PageView1({super.key});

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
                    onPressed: () {
                      return  context.go("/login");
                    },
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
