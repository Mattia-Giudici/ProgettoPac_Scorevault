import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/Models/model_user.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';
import 'package:scorevault/views/widgets/texts/sv_standard_text.dart';

class SvFriendrequestListtile extends StatelessWidget {
  final ModelUser user;
  const SvFriendrequestListtile({super.key, required this.user});

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
                backgroundColor: Theme.of(context).colorScheme.onSurface.withAlpha(100),
                child: user.profileImageUrl == null 
                  ? Icon(Icons.person, color: Theme.of(context).colorScheme.surface ) 
                  : Image(image: NetworkImage(user.profileImageUrl!)),
              ),
              title: SvBoldText(text: user.getUsername, size: 16, textColor: Theme.of(context).colorScheme.onSurface),
              subtitle: SvStandardText(text: user.getEmail, size: 12, textColor: Theme.of(context).colorScheme.onSurface),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),

              child: Row(
                spacing: 8,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.close_rounded, color: AppColors.lightSurface),
                      label: SvBoldText(text: "Rifiuta", size: 12, textColor: AppColors.lightSurface),

                      style: ElevatedButton.styleFrom(
                        
                        backgroundColor: AppColors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        context.read<AuthProvider>().rejectFriendRequest(user.getUid);
                      },
                    ),
                  ),
                    Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.check, color: AppColors.lightSurface),
                      label: SvBoldText(text: "Accetta", size: 12, textColor: AppColors.lightSurface),

                      style: ElevatedButton.styleFrom(
                        
                        backgroundColor: AppColors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        context.read<AuthProvider>().acceptFriendRequest(user.getUid);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
