import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/utils/theme.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/screens/auth/welcome_screen.dart';
import 'package:scorevault/views/screens/homepage/homepag_screen.dart';

class App extends StatelessWidget {

  const App({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: authProvider.isLogged() ? const HomePageScreen() : const WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}