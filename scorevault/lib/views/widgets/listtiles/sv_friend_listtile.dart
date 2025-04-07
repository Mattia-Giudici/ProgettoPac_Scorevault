import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/Models/model_user.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';
import 'package:scorevault/views/widgets/texts/sv_standard_text.dart';

class SvFriendListtile extends StatelessWidget {
  final ModelUser user;
  const SvFriendListtile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
     return Column(
       children: [
         Divider(
           color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
           height: 1,
         ),
         ListTile(
           leading:CircleAvatar(
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
           title: SvBoldText(text: user.getUsername, size: 16, textColor: Theme.of(context).colorScheme.onSurface),
           subtitle: SvStandardText(text: user.getEmail, size: 12, textColor: Theme.of(context).colorScheme.onSurface),
            trailing: IconButton(
              onPressed: () {
                context.read<AuthProvider>().removeFriend(user.getUid);
              },
              icon: Icon(Icons.delete, color: AppColors.red),
            ),
         ),
        
       ],
     );
  }
}