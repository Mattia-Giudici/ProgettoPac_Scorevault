import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/views/widgets/buttons/sv_standard_button.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';
import 'package:scorevault/views/widgets/texts/sv_standard_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // logo
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(64.0),
                    child: Image.asset("assets/logo.png", fit: BoxFit.fill),
                  ),
                ),
              ),
              SvBoldText(
                text: "Scorevault",
                size: 32,
                textColor: Theme.of(context).colorScheme.onSurface,
              ),
              SvStandardText(
                text:
                    "Accedi all'applicazione con le tue credenziali, oppure registra un nuovo account",
                size: 12,
                textColor: Theme.of(context).colorScheme.onSurface,
              ),

              Spacer(),
              SvStandardButton(
                text: "Accedi",
                function: () {
                  context.push('/login');
                },
                color: Theme.of(context).colorScheme.primary,
                textColor: AppColors.lightSurface,
              ),
              SizedBox(height: 16),
              SvStandardButton(
                text: "Registrati",
                function: () {
                  context.push('/signup');
                },
                color: Theme.of(context).colorScheme.primaryContainer,
                textColor: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
