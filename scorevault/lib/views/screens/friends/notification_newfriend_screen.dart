import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/Models/model_user.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/widgets/listtiles/sv_friendnotification_listtile.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';

class NotificationNewfriendScreen extends StatelessWidget {
  const NotificationNewfriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        title: SvBoldText(
          text: "Notifiche",
          size: 24,
          textColor: AppColors.lightSurface,
        ),
        actionsPadding: EdgeInsets.only(right: 8),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
       
      ),

      body:
          StreamBuilder<List<ModelUser>>(
            stream: context.read<AuthProvider>().getFriendsRequests(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: SvBoldText(
                    text: "Nessuna richiesta di amicizia",
                    size: 16,
                    textColor: Theme.of(context).colorScheme.onSurface,
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<AuthProvider>().getFriendsRequests();
                },
                child: Column(
                  children: [
                    ListTile(
                      title: SvBoldText(text: "Richieste di amicizia", size: 16, textColor: Theme.of(context).colorScheme.onSurface),
                      trailing: SvBoldText(text: snapshot.data!.length.toString(), size: 16, textColor: Theme.of(context).colorScheme.onSurface),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom:8),
                      child: Divider(
                        color: Theme.of(context).colorScheme.onSurface.withAlpha(50),
                        height: 1,
                      ),
                    ),
                    
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) { 
                          return SvFriendnotificationListtile(
                            user: snapshot.data![index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
    );
  }
}
