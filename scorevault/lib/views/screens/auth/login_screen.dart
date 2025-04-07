import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/screens/auth/forgot_password.dart';
import 'package:scorevault/views/screens/auth/signup_screen.dart';
import 'package:scorevault/views/screens/auth/welcome_screen.dart';
import 'package:scorevault/views/screens/homepage/homepag_screen.dart';
import 'package:scorevault/views/widgets/buttons/sv_standard_button.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';
import 'package:scorevault/views/widgets/texts/sv_standard_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  final TextEditingController _mailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  late final AuthProvider _authProvider;
  @override
  void dispose() {
    super.dispose();
    _mailcontroller.dispose();
    _passwordcontroller.dispose();
  }

  @override
  void initState() {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: SvBoldText(
          text: "Login",
          size: 24,
          textColor: AppColors.lightSurface,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        child: SvBoldText(
                          text: "Email",
                          size: 16,
                          textColor: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    TextFormField(
                      autofocus: false,
                      controller: _mailcontroller,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.all(24),
                        labelStyle: SvStandardText.getTextStyle(
                          size: 16,
                          textColor: Theme.of(context).colorScheme.onSurface,
                        ),
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.primaryContainer,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Inserisci la tua email';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Email non valida';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvBoldText(
                          text: "Password",
                          size: 16,
                          textColor: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
                    ),
                    TextFormField(
                      autofocus: false,
                      controller: _passwordcontroller,
                      keyboardType: TextInputType.text,
                      obscureText: _passwordVisible,
                      enableSuggestions: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.all(24),
                        labelStyle: SvStandardText.getTextStyle(
                          size: 16,
                          textColor: Theme.of(context).colorScheme.onSurface,
                        ),
                        filled: true,
                        fillColor:
                            Theme.of(context).colorScheme.primaryContainer,
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: IconButton(
                            icon: Icon(
                              _passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Inserisci la password';
                        }
                        if (value.length < 6) {
                          return 'Password non valida';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ForgotPassword(),
                            ),
                          );
                        },
                        child: SvBoldText(
                          text: "Password dimenticata?",
                          size: 12,
                          textColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    SvStandardButton(
                      text: "Accedi",
                      function: () {
                        _performLogin(context);
                      },
                      color: Theme.of(context).colorScheme.primary,
                      textColor: AppColors.lightSurface,
                    ),
                    const SizedBox(height: 16),
                    SvStandardText(
                      text: " - Oppure - ",
                      size: 12,
                      textColor: Theme.of(context).colorScheme.onSurface,
                    ),
                    const SizedBox(height: 16),
                    SvStandardButton(
                      text: "Crea un account",
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ),
                        );
                      },
                      color: Theme.of(context).colorScheme.primaryContainer,
                      textColor: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showProgressIndicator(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Impedisce la chiusura accidentale
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> _performLogin(BuildContext context) async {
    _showProgressIndicator(context);
    if (_formKey.currentState!.validate()) {
      try {
        await _authProvider.signin(
          _mailcontroller.text,
          _passwordcontroller.text,
        );
        Navigator.pop(context); // Chiude il loader quando la login ha successo
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePageScreen()),
        );
      } catch (e) {
        Navigator.pop(context); // Chiude il loader prima di mostrare l'errore
        FocusScope.of(context).unfocus(); // Rimuove il focus dai campi di input
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } else {
      Navigator.pop(context); // Chiude il loader se la validazione fallisce
      FocusScope.of(
        context,
      ).unfocus(); // Rimuove il focus per evitare la tastiera
    }
  }
}
/*
 

*/

/**
 * Exception has occurred.
ProviderNotFoundException (Error: Could not find the correct Provider<AuthProvider> above this LoginScreen Widget

This happens because you used a `BuildContext` that does not include the provider
of your choice. There are a few common scenarios:

- You added a new provider in your `main.dart` and performed a hot-reload.
  To fix, perform a hot-restart.

- The provider you are trying to read is in a different route.

  Providers are "scoped". So if you insert of provider inside a route, then
  other routes will not be able to access that provider.

- You used a `BuildContext` that is an ancestor of the provider you are trying to read.

  Make sure that LoginScreen is under your MultiProvider/Provider<AuthProvider>.
  This usually happens when you are creating a provider and trying to read it immediately.

  For example, instead of:

  ```
  Widget build(BuildContext context) {
    return Provider<Example>(
      create: (_) => Example(),
      // Will throw a ProviderNotFoundError, because `context` is associated
      // to the widget that is the parent of `Provider<Example>`
      child: Text(context.watch<Example>().toString()),
    );
  }
  ```

  consider using `builder` like so:

  ```
  Widget build(BuildContext context) {
    return Provider<Example>(
      create: (_) => Example(),
      // we use `builder` to obtain a new `BuildContext` that has access to the provider
      builder: (context, child) {
        // No longer throws
        return Text(context.watch<Example>().toString());
      }
    );
  }
  ```
 */
