// // import 'package:flutter/material.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:go_router/go_router.dart';

// // // For context: https://github.com/flutter/flutter/issues/112915.

// // // This is crucial for making sure that the same navigator is used
// // // when rebuilding the GoRouter and not throwing away the whole widget tree.
// // final _navigatorKey = GlobalKey<NavigatorState>();
// // // We need to make sure we have access to the location of the previous router
// // // instance. Otherwise, we will always be redirected to '/' on rebuild.
// // GoRouter? _previousRouter;



// // final routerProvider = Provider<GoRouter>(
// //   (ref) {
// //     // Using riverpod *directly* for authentication redirection.
// //     // This scales to as many dependencies as needed.
// //     final loggedIn = ref.watch(loggedInProvider);

// //     return _previousRouter = GoRouter(
// //       initialLocation: _previousRouter?.location,
// //       navigatorKey: _navigatorKey,
// //       routes: [
// //         GoRoute(
// //           path: '/',
// //           builder: (context, state) => const HomeScreen(),
// //         ),
// //         GoRoute(
// //           path: '/login',
// //           builder: (context, state) => const LoginScreen(),
// //         ),
// //       ],
// //       redirect: (context, state) {
// //         // The redirection function is completely customizable and
// //         // is called for both dependency changes and internal navigation.
// //         final loggingIn = state.location == '/login';
// //         if (!loggedIn) {
// //           if (!loggingIn) return '/login';
// //           return null;
// //         }

// //         if (loggingIn) return '/';
// //         return null;
// //       },
// //     );
// //   },
// // );

// // final loggedInProvider = StateProvider<bool>((ref) => false);

// // void main() => runApp(const ProviderScope(child: App()));

// // class App extends ConsumerWidget {
// //   const App({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     // Only this build function is always called when dependencies update.
// //     // Pages and children are not rebuilt if navigation does not change due
// //     // to Flutter checking if widgets in the tree are the still the same
// //     // and not rebuilding them if so.
// //     final router = ref.watch(routerProvider);
// //     return MaterialApp.router(
// //       routerConfig: router,
// //       debugShowCheckedModeBanner: false,
// //     );
// //   }
// // }

// // class LoginScreen extends ConsumerStatefulWidget {
// //   const LoginScreen({Key? key}) : super(key: key);

// //   @override
// //   ConsumerState<LoginScreen> createState() => _LoginScreenState();
// // }

// // class _LoginScreenState extends ConsumerState<LoginScreen>
// //     with TickerProviderStateMixin {
// //   late final _controller = AnimationController(
// //     vsync: this,
// //     duration: const Duration(seconds: 1),
// //   )..addStatusListener((status) {
// //       if (status != AnimationStatus.completed) return;
// //       // Update the logged in state after the animation for demo purposes.
// //       ref.read(loggedInProvider.notifier).state = true;
// //     });

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: AnimatedBuilder(
// //           animation: _controller,
// //           builder: (context, child) {
// //             return Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 if (_controller.isAnimating)
// //                   CircularProgressIndicator(value: _controller.value)
// //                 else
// //                   child!,
// //               ],
// //             );
// //           },
// //           child: ElevatedButton(
// //             onPressed: _controller.forward,
// //             child: const Text('Login'),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class HomeScreen extends ConsumerWidget {
// //   const HomeScreen({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context, WidgetRef ref) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         actions: <Widget>[
// //           IconButton(
// //             onPressed: () => ref.read(loggedInProvider.notifier).state = false,
// //             tooltip: 'Logout',
// //             icon: const Icon(Icons.logout),
// //           )
// //         ],
// //       ),
// //       body: const Center(
// //         child: Text('Home'),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'sign_in_form.dart';

// void showCustomDialog(BuildContext context, {required ValueChanged onValue}) {
//   showGeneralDialog(
//     context: context,
//     barrierLabel: "Barrier",
//     barrierDismissible: true,
//     barrierColor: Colors.black.withOpacity(0.5),
//     transitionDuration: const Duration(milliseconds: 400),
//     pageBuilder: (_, __, ___) {
//       return Center(
//         child: Container(
//           height: 620,
//           margin: const EdgeInsets.symmetric(horizontal: 16),
//           padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
//           decoration: BoxDecoration(
//             color: Colors.white.withOpacity(0.95),
//             borderRadius: BorderRadius.circular(40),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.3),
//                 offset: const Offset(0, 30),
//                 blurRadius: 60,
//               ),
//               const BoxShadow(
//                 color: Colors.black45,
//                 offset: Offset(0, 30),
//                 blurRadius: 60,
//               ),
//             ],
//           ),
//           child: Scaffold(
//             backgroundColor: Colors.transparent,
//             body: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Column(
//                   children: [
//                     const Text(
//                       "Sign in",
//                       style: TextStyle(
//                         fontSize: 34,
//                         fontFamily: "Poppins",
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       child: Text(
//                         "Access to 240+ hours of content. Learn design and code, by building real apps with Flutter and Swift.",
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                     const SignInForm(),
//                     Row(
//                       children: const [
//                         Expanded(
//                           child: Divider(),
//                         ),
//                         Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 16),
//                           child: Text(
//                             "OR",
//                             style: TextStyle(
//                               color: Colors.black26,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         Expanded(child: Divider()),
//                       ],
//                     ),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(vertical: 24),
//                       child: Text(
//                         "Sign up with Email, Apple or Google",
//                         style: TextStyle(color: Colors.black54),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         IconButton(
//                           onPressed: () {},
//                           padding: EdgeInsets.zero,
//                           icon: SvgPicture.asset(
//                             "assets/icons/email_box.svg",
//                             height: 64,
//                             width: 64,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {},
//                           padding: EdgeInsets.zero,
//                           icon: SvgPicture.asset(
//                             "assets/icons/apple_box.svg",
//                             height: 64,
//                             width: 64,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {},
//                           padding: EdgeInsets.zero,
//                           icon: SvgPicture.asset(
//                             "assets/icons/google_box.svg",
//                             height: 64,
//                             width: 64,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const Positioned(
//                   left: 0,
//                   right: 0,
//                   bottom: -48,
//                   child: CircleAvatar(
//                     radius: 16,
//                     backgroundColor: Colors.white,
//                     child: Icon(
//                       Icons.close,
//                       size: 20,
//                       color: Colors.black,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//     transitionBuilder: (_, anim, __, child) {
//       Tween<Offset> tween;
//       // if (anim.status == AnimationStatus.reverse) {
//       //   tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
//       // } else {
//       //   tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
//       // }

//       tween = Tween(begin: const Offset(0, -1), end: Offset.zero);

//       return SlideTransition(
//         position: tween.animate(
//           CurvedAnimation(parent: anim, curve: Curves.easeInOut),
//         ),
//         // child: FadeTransition(
//         //   opacity: anim,
//         //   child: child,
//         // ),
//         child: child,
//       );
//     },
//   ).then(onValue);
// }
