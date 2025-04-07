import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/screens/auth/welcome_screen.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';
import 'package:scorevault/views/widgets/texts/sv_standard_text.dart';

/**
 *   authProvider.signout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
 */
class TabAccount extends StatelessWidget {
  const TabAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        title: SvBoldText(
          text: "Account",
          size: 24,
          textColor: AppColors.lightSurface,
        ),
        actionsPadding: EdgeInsets.only(right: 8),
        actions: [
          IconButton.filled(
            onPressed: () {},
            icon: Icon(Icons.notifications_rounded),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.person_add_alt_rounded,
                  size: 80,
                  color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
                ),
              ),
              SizedBox(height: 16),
              SvBoldText(
                text:
                    context
                        .read<AuthProvider>()
                        .currentFirebaseUser!
                        .displayName!,
                size: 24,
                textColor: Theme.of(context).colorScheme.onSurface,
              ),
              SvStandardText(
                text: context.read<AuthProvider>().currentFirebaseUser!.email!,
                size: 12,
                textColor: Theme.of(context).colorScheme.onSurface,
              ),

              SizedBox(height: 64),
              _buildDivider(context),

              _buildListTile(
                context,
                Icons.people_rounded,
                "Amici",
                () {
                
                },
                SvBoldText(
                  text: "3",
                  size: 18,
                  textColor: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              _buildDivider(context),

              _buildListTile(context, Icons.logout_rounded, "Esci", () {
                context.read<AuthProvider>().signout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              }, null),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Divider(
        color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
        height: 1,
      ),
    );
  }

  Widget _buildListTile(
    BuildContext context,
    IconData icon,
    String text,
    void Function() onTap,
    Widget? trailing,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24),
      trailing: trailing,
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(icon, color: AppColors.lightSurface),
      ),
      title: SvBoldText(
        text: text,
        size: 16,
        textColor: Theme.of(context).colorScheme.onSurface,
      ),
      onTap: () {
        onTap();
      },
    );
  }
}
