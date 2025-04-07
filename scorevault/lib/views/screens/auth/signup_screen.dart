import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/screens/auth/login_screen.dart';
import 'package:scorevault/views/screens/homepage/homepag_screen.dart';
import 'package:scorevault/views/widgets/buttons/sv_standard_button.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';
import 'package:scorevault/views/widgets/texts/sv_standard_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = true;
  final TextEditingController _mailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _confirmpasswordcontroller =
      TextEditingController();
  final TextEditingController _usernamecontroller = TextEditingController();

  late final AuthProvider _authProvider;
  @override
  void dispose() {
    super.dispose();
    _mailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmpasswordcontroller.dispose();
    _usernamecontroller.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Sposta questo nella didChangeDependencies o dopo build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _authProvider = Provider.of<AuthProvider>(context, listen: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Rimuovi questa riga per permettere alla schermata di ridimensionarsi quando appare la tastiera
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: SvBoldText(
          text: "Crea un account",
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
          child: Form(
            autovalidateMode: AutovalidateMode.disabled,
            key: _formKey,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Aggiungi spazio in cima per rendere il form più al centro quando non è visibile la tastiera
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: SvBoldText(
                        text: "Nome utente",
                        size: 16,
                        textColor: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                  TextFormField(
                    autofocus: false,
                    controller: _usernamecontroller,
                    keyboardType: TextInputType.text,
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
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Inserisci nome utente';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 8),
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
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
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
                        text: "Password e conferma",
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
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
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

                  TextFormField(
                    autofocus: false,
                    controller: _confirmpasswordcontroller,
                    keyboardType: TextInputType.text,
                    obscureText: _passwordVisible,
                    enableSuggestions: false,
                    // Cambia da next a done per consentire la chiusura facile della tastiera
                    textInputAction: TextInputAction.done,
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
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Conferma password';
                      }
                      if (value != _passwordcontroller.text) {
                        return 'Conferma password non valida';
                      }
                      return null;
                    },
                    // Aggiungi questo per consentire la chiusura facile della tastiera
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 16),

                  SvStandardButton(
                    text: "Registra account",
                    function: () {
                      _performRegister(context);
                    },
                    color: Theme.of(context).colorScheme.primary,
                    textColor: AppColors.lightSurface,
                  ),
                  const SizedBox(height: 16),
                  SvStandardText(
                    text: " - Hai già un account? - ",
                    size: 12,
                    textColor: Theme.of(context).colorScheme.onSurface,
                  ),
                  const SizedBox(height: 16),
                  SvStandardButton(
                    text: "Accedi",
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    color: Theme.of(context).colorScheme.primaryContainer,
                    textColor: Theme.of(context).colorScheme.primary,
                  ),
                  // Aggiungi spazio alla fine per garantire la scrollabilità oltre l'ultimo elemento
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                ],
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

  Future<void> _performRegister(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _showProgressIndicator(context);
      try {
        await _authProvider.signup(
          _mailcontroller.text,
          _passwordcontroller.text,
          _usernamecontroller.text,
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
      FocusScope.of(
        context,
      ).unfocus(); // Rimuove il focus per evitare la tastiera
    }
  }
}
