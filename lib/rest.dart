// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// // For context: https://github.com/flutter/flutter/issues/112915.

// // This is crucial for making sure that the same navigator is used
// // when rebuilding the GoRouter and not throwing away the whole widget tree.
// final _navigatorKey = GlobalKey<NavigatorState>();
// // We need to make sure we have access to the location of the previous router
// // instance. Otherwise, we will always be redirected to '/' on rebuild.
// GoRouter? _previousRouter;



// final routerProvider = Provider<GoRouter>(
//   (ref) {
//     // Using riverpod *directly* for authentication redirection.
//     // This scales to as many dependencies as needed.
//     final loggedIn = ref.watch(loggedInProvider);

//     return _previousRouter = GoRouter(
//       initialLocation: _previousRouter?.location,
//       navigatorKey: _navigatorKey,
//       routes: [
//         GoRoute(
//           path: '/',
//           builder: (context, state) => const HomeScreen(),
//         ),
//         GoRoute(
//           path: '/login',
//           builder: (context, state) => const LoginScreen(),
//         ),
//       ],
//       redirect: (context, state) {
//         // The redirection function is completely customizable and
//         // is called for both dependency changes and internal navigation.
//         final loggingIn = state.location == '/login';
//         if (!loggedIn) {
//           if (!loggingIn) return '/login';
//           return null;
//         }

//         if (loggingIn) return '/';
//         return null;
//       },
//     );
//   },
// );

// final loggedInProvider = StateProvider<bool>((ref) => false);

// void main() => runApp(const ProviderScope(child: App()));

// class App extends ConsumerWidget {
//   const App({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Only this build function is always called when dependencies update.
//     // Pages and children are not rebuilt if navigation does not change due
//     // to Flutter checking if widgets in the tree are the still the same
//     // and not rebuilding them if so.
//     final router = ref.watch(routerProvider);
//     return MaterialApp.router(
//       routerConfig: router,
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

// class LoginScreen extends ConsumerStatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   ConsumerState<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends ConsumerState<LoginScreen>
//     with TickerProviderStateMixin {
//   late final _controller = AnimationController(
//     vsync: this,
//     duration: const Duration(seconds: 1),
//   )..addStatusListener((status) {
//       if (status != AnimationStatus.completed) return;
//       // Update the logged in state after the animation for demo purposes.
//       ref.read(loggedInProvider.notifier).state = true;
//     });

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: AnimatedBuilder(
//           animation: _controller,
//           builder: (context, child) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (_controller.isAnimating)
//                   CircularProgressIndicator(value: _controller.value)
//                 else
//                   child!,
//               ],
//             );
//           },
//           child: ElevatedButton(
//             onPressed: _controller.forward,
//             child: const Text('Login'),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: <Widget>[
//           IconButton(
//             onPressed: () => ref.read(loggedInProvider.notifier).state = false,
//             tooltip: 'Logout',
//             icon: const Icon(Icons.logout),
//           )
//         ],
//       ),
//       body: const Center(
//         child: Text('Home'),
//       ),
//     );
//   }
// }
