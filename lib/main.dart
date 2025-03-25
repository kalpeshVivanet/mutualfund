// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:go_router/go_router.dart';

// import 'screens/auth_service.dart';
// import 'services/dashboard_screen.dart';
// import 'services/login_screen.dart';
// import 'services/signup_screen.dart';


// void main() async {
//   // Initialize Supabase
//   await Supabase.initialize(
//     url: 'https://tugrpicamkxebaiozbqt.supabase.co',
//     anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR1Z3JwaWNhbWt4ZWJhaW96YnF0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI5MTU2MTcsImV4cCI6MjA1ODQ5MTYxN30.VkZpR17VuJUMR87HTvqxGOp7Jiks21hX6Ct_MHViVfw',
//   );

//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => AuthService()),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   MyApp({Key? key}) : super(key: key);

//   late final GoRouter _router = GoRouter(
//     routes: [
//       GoRoute(
//         path: '/',
//         builder: (context, state) => const LoginScreen(),
//       ),
//       GoRoute(
//         path: '/signup',
//         builder: (context, state) => const SignUpScreen(),
//       ),
//       GoRoute(
//         path: '/dashboard',
//         builder: (context, state) => const DashboardScreen(),
//       ),
//     ],
//     redirect: (BuildContext context, GoRouterState state) {
//       final authService = context.read<AuthService>();
//       final isLoggedIn = authService.isLoggedIn;
//       final isLoggingIn = state.matchedLocation == '/' || state.matchedLocation == '/signup';

//       if (!isLoggedIn && !isLoggingIn) return '/';
//       if (isLoggedIn && isLoggingIn) return '/dashboard';
//       return null;
//     },
//   );

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'Mutual Fund Analytics',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       routerConfig: _router,
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import 'screens/auth_service.dart';
import 'services/dashboard_screen.dart';
import 'services/login_screen.dart';
import 'services/signup_screen.dart';


void main() async {
  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://tugrpicamkxebaiozbqt.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InR1Z3JwaWNhbWt4ZWJhaW96YnF0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI5MTU2MTcsImV4cCI6MjA1ODQ5MTYxN30.VkZpR17VuJUMR87HTvqxGOp7Jiks21hX6Ct_MHViVfw',
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  late final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final authService = context.read<AuthService>();
      final isLoggedIn = authService.isLoggedIn;
      final isLoggingIn = state.matchedLocation == '/' || state.matchedLocation == '/signup';

      if (!isLoggedIn && !isLoggingIn) return '/';
      if (isLoggedIn && isLoggingIn) return '/dashboard';
      return null;
    },
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mutual Fund Analytics',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routerConfig: _router,
    );
  }
}