import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/Models/model_user.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/screens/friends/newfriends_screen.dart';
import 'package:scorevault/views/widgets/listtiles/sv_friend_listtile.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';

class FriendlistScreen extends StatelessWidget {
  
  const FriendlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        title: SvBoldText(text: "Amici", size: 24, textColor: AppColors.lightSurface),
        actionsPadding: EdgeInsets.only(right: 8),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: StreamBuilder(
        stream: context.read<AuthProvider>().getFriendsList(),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<ModelUser>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return Column(
              children: [
                ListTile(
                  title: SvBoldText(text: "I tuoi amici", size: 18, textColor: Theme.of(context).colorScheme.onSurface),
                  trailing: SvBoldText(text: snapshot.data!.length.toString(), size: 16, textColor: Theme.of(context).colorScheme.onSurface),
                ),
              
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SvFriendListtile(user: snapshot.data![index]);
                    },
                  ),
                ),
              ],
            );
          }
          return Center(
            child: SvBoldText(
              text: "Non hai nessun amico",
              size: 16,
              textColor: Theme.of(context).colorScheme.onSurface,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NewfriendsScreen()));
        },
        child: Icon(Icons.add, color: AppColors.lightSurface,),
      ),
    );
  }
}
