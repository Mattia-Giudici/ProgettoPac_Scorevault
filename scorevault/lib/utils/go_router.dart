import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/screens/auth/forgot_password.dart';
import 'package:scorevault/views/screens/auth/login_screen.dart';
import 'package:scorevault/views/screens/auth/signup_screen.dart';
import 'package:scorevault/views/screens/auth/welcome_screen.dart';
import 'package:scorevault/views/screens/generic_games/game_screen.dart';
import 'package:scorevault/views/screens/homepage/homepag_screen.dart';
import 'package:scorevault/views/screens/homepage/newfriend_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        return authProvider.isLogged() ? '/home' : '/welcome';
      },
    ),
    GoRoute(
      path: '/welcome',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const WelcomeScreen(),
      ),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: '/signup',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const SignupScreen(),
      ),
    ),
    GoRoute(
      path: '/forgot-password',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const ForgotPassword(),
      ),
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const HomePageScreen(),
      ),
    ),
    GoRoute(
      path: '/new-friend',
      pageBuilder: (context, state) => MaterialPage(
        key: state.pageKey,
        child: const NewfriendScreen(),
      ),
    ),
    GoRoute(
      path: '/game/:name',
      pageBuilder: (context, state) {
        final gameName = state.pathParameters['name'] ?? 'Gioco';
        return MaterialPage(
          key: state.pageKey,
          child: GameScreen(gameName: gameName),
        );
      },
    ),
  ],
  redirect: (context, state) {
    final authProvider = context.read<AuthProvider>();
    final isLoggedIn = authProvider.isLogged();
    final isAuthRoute = _authRoutes.contains(state.uri.toString());

    if (!isLoggedIn && !isAuthRoute) return '/welcome';
    if (isLoggedIn && isAuthRoute) return '/home';
    
    return null;
  },
);

final _authRoutes = ['/welcome', '/login', '/signup', '/forgot-password'];
