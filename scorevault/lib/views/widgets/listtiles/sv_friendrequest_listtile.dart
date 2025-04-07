import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/Models/model_user.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';
import 'package:scorevault/views/widgets/texts/sv_standard_text.dart';

class SvFriendrequestListtile extends StatelessWidget {
  final ModelUser user;
  final bool isRequestSent;
  const SvFriendrequestListtile({super.key, required this.user, required this.isRequestSent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.onSurface.withAlpha(100),
                backgroundImage:
                    user.profileImageUrl != null
                        ? NetworkImage(user.profileImageUrl!)
                        : null,
                child:
                    user.profileImageUrl == null
                        ? Icon(
                          Icons.person,
                          color: Theme.of(context).colorScheme.surface,
                        )
                        : null,
              ),
              title: SvBoldText(
                text: user.getUsername,
                size: 16,
                textColor: Theme.of(context).colorScheme.onSurface,
              ),
              subtitle: SvStandardText(
                text: user.getEmail,
                size: 12,
                textColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.send_rounded, color: AppColors.lightGrey,),
                  style: ElevatedButton.styleFrom(
                    elevation: 0.5,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    context.read<AuthProvider>().sendFriendRequest(user.getUid);
                  },
                  label: SvBoldText(
                    text: "Invia richiesta",
                    size: 12,
                    textColor: AppColors.lightGrey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
