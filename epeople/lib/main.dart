import 'package:epeople/pages/createAccountPage.dart';
import 'package:epeople/pages/loginOrcreataccountPage.dart';
import 'package:epeople/pages/loginPage.dart';
import 'package:epeople/pages/principalPage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}


class AuthService {
  bool isAuthenticated = true;
  String? userRole;
}

final authService = AuthService();

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => Loginpage(),
    ),
     GoRoute(
      path: '/loginOrCreateAccount',
      builder: (context, state) => Loginorcreataccountpage(),
    ),
    GoRoute(
      path: '/create_account',
      builder: (context, state) => Createaccountpage(),
      redirect: (context, state) {
        if (authService.isAuthenticated) {
          return '/';
        }
        return null;
      },
    ),
     GoRoute(
      path: '/principal',
      builder: (context, state) => Principalpage(),
      redirect: (context, state) {
        if (!authService.isAuthenticated) {
          return '/';
        }
        return null;
      },
    ),
    GoRoute(
      path: '/',
      builder: (context, state) => Principalpage(),
      redirect: (context, state) {
        if (!authService.isAuthenticated) {
          return '/loginOrCreateAccount';
        }
        if (authService.userRole != 'admin') {
          return '/principal';
        }
        return null;
      },
    ),
  ],
);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ePeople',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}