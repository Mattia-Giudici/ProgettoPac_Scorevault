import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/widgets/buttons/sv_standard_button.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';
import 'package:scorevault/views/widgets/texts/sv_standard_text.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
    final _formKey = GlobalKey<FormState>();
  final TextEditingController _mailcontroller = TextEditingController();
  late final AuthProvider _authProvider;

  @override
  void dispose() {
    super.dispose();
    _mailcontroller.dispose();
  }

  @override
  void initState() {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 SvBoldText(
                text: "Recupera password",
                size: 24,
                textColor: Theme.of(context).colorScheme.onSurface,
              ),
              SvStandardText(
                text:
                    "Inserisci l'indirizzo email del tuo account, ti verrà inviato un link con cui potrai procedere con il recupero della password",
                size: 12,
                textColor: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(height: 48,),
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
                const SizedBox(height: 16),
                SvStandardButton(
                  text: "Invia mail di recupero",
                  function: () {
                    _performForgotPassword(context);
                  },
                  color: Theme.of(context).colorScheme.primary,
                  textColor: AppColors.lightSurface,
                ),
                
              ],
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

  Future <void> _performForgotPassword(BuildContext context) async{
_showProgressIndicator(context);
    if (_formKey.currentState!.validate()) {
      try {
        await _authProvider.forgotPassword(_mailcontroller.text);
        Navigator.pop(context); // Chiude il loader quando la login ha successo
        context.go('/welcome');
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Email di recupro inviata"),
            duration: const Duration(seconds: 3),
          ),
        );
      } catch (e) {
        Navigator.pop(context); // Chiude il loader prima di mostrare l'errore
        FocusScope.of(context).unfocus(); // Rimuove il focus dai campi di input
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            duration: const Duration(seconds: 3),
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
