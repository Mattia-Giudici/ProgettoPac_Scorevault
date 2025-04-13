import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/Models/model_user.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/screens/auth/welcome_screen.dart';
import 'package:scorevault/views/screens/friends/friendlist_screen.dart';
import 'package:scorevault/views/screens/friends/notification_newfriend_screen.dart';
import 'package:scorevault/views/widgets/buttons/sv_iconprofile_button.dart';
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
  TabAccount({super.key});

  final ImagePicker _picker = ImagePicker();

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
          StreamBuilder<ModelUser>(
            stream: context.read<AuthProvider>().fetchUserData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return IconButton.filled(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationNewfriendScreen(),
                      ),
                    );
                  },
                  icon: Badge(
                    smallSize: 12,
                    alignment: Alignment.topRight,
                    isLabelVisible:
                        snapshot.data!.pendingFriendsList.isNotEmpty,
                    child: Icon(Icons.notifications_rounded),
                  ),
                );
              }
              return Container();
            },
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
              StreamBuilder(
                stream: context.read<AuthProvider>().fetchUserData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.waiting) {
                    if (snapshot.hasData) {
                      return SvIconprofileButton(
                        radius: 60,
                        enableImagePicker: true, 
                        imageUrl: snapshot.data!.getProfileImageUrl!);
                    }
                  }
                  return Icon(
                    Icons.person_add_alt_rounded,
                    size: 80,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withAlpha(150),
                  );
                },
              ),
              SizedBox(height: 16),
              SvBoldText(
                text:
                    context
                        .read<AuthProvider>()
                        .getCurrentUser()
                        .currentUser!
                        .displayName ??
                    "",
                size: 24,
                textColor: Theme.of(context).colorScheme.onSurface,
              ),
              SvStandardText(
                text:
                    context
                        .read<AuthProvider>()
                        .getCurrentUser()
                        .currentUser!
                        .email!,
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
              StreamBuilder<ModelUser>(
                stream: context.read<AuthProvider>().fetchUserData(),

                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return _buildListTile(
                      context,
                      Icons.people_rounded,
                      "Amici",
                      () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FriendlistScreen(),
                          ),
                        );
                      },
                      SvBoldText(
                        text: snapshot.data!.friendsList.length.toString(),
                        size: 18,
                        textColor: Theme.of(context).colorScheme.onSurface,
                      ),
                      Theme.of(context).colorScheme.onSurface.withAlpha(100),
                    );
                  }
                  return Container();
                },
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

  // Metodo per aprire la galleria
  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 90,
      );

      if (image != null) {
        // Usa l'immagine selezionata
        Uint8List imageBytes = await image.readAsBytes();
        // ... fai qualcosa con imageBytes
      }
    } catch (e) {
      print("Errore nella selezione dell'immagine: $e");
    }
  }
}
