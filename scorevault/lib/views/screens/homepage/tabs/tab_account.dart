import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/screens/auth/welcome_screen.dart';
import 'package:scorevault/views/screens/friends/notification_newfriend_screen.dart';
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
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationNewfriendScreen()));
            },
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
                        .currentUser!.displayName! ?? "",
                size: 24,
                textColor: Theme.of(context).colorScheme.onSurface,
              ),
              SvStandardText(
                text: context.read<AuthProvider>().currentUser!.email!,
                size: 12,
                textColor: Theme.of(context).colorScheme.onSurface,
              ),

              SizedBox(height: 64),

              // Modifica profilo
              _buildDivider(context),
              _buildListTile(
                context,
                Icons.person_pin_rounded,
                "Modifica profilo",
                () {},
                null,
                Theme.of(context).colorScheme.onSurface.withAlpha(100),
              ),
              // Statistiche partite
              _buildDivider(context),
              _buildListTile(
                context,
                Icons.bar_chart_rounded,
                "Statistiche partite",
                () {},
                null,
                Theme.of(context).colorScheme.onSurface.withAlpha(100),
              ),
              // amici
              _buildDivider(context),
              _buildListTile(
                context,
                Icons.people_rounded,
                "Amici",
                () {},
                SvBoldText(
                  text: "0",
                  size: 18,
                  textColor: Theme.of(context).colorScheme.onSurface,
                ),
                Theme.of(context).colorScheme.onSurface.withAlpha(100),
              ),

              // logout
              _buildDivider(context),
              _buildListTile(
                context,
                Icons.logout_rounded,
                "Esci",
                () {
                  context.read<AuthProvider>().signout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => WelcomeScreen()),
                  );
                },
                null,
                AppColors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
    Color iconColor,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      trailing: trailing,
      leading: CircleAvatar(
        backgroundColor: iconColor,
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
