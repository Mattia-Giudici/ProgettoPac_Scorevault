import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';

class TabAccount extends StatelessWidget {
  TabAccount({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider _authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SvBoldText(
          text: "Account",
          size: 24,
          textColor: Theme.of(context).colorScheme.onSurface,
        ),
        actions: [
          CircleAvatar(
            backgroundColor: AppColors.red,
            child: IconButton(
              onPressed: () {
                _authProvider.signout();
                context.pushReplacement('/welcome');
              },
              icon: Icon(Icons.logout_rounded, color: AppColors.lightSurface,),
            ),
          ),
          SizedBox(width: 16,)
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 16),
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Icon(Icons.person_2_rounded, size: 48,color: AppColors.lightSurface,),
                  ),
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 16),
                      title: SvBoldText(
                        text:
                            _authProvider
                                .getFirebaseAuthInstance
                                .currentUser!
                                .displayName!,
                        size: 18,
                        textColor: Theme.of(context).colorScheme.onSurface,
                      ),
                      subtitle: SvBoldText(
                        text:
                            _authProvider
                                .getFirebaseAuthInstance
                                .currentUser!
                                .email!,
                        size: 12,
                        textColor: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          context.push('/new-friend');
        },
        child: Icon(Icons.person_add_alt_1_rounded,color: AppColors.lightSurface,),
      ),
    );
  }
}
