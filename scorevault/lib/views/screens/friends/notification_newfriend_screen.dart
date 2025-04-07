import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/Models/model_user.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/widgets/listtiles/sv_friendrequest_listtile.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';

class NotificationNewfriendScreen extends StatefulWidget {
  const NotificationNewfriendScreen({super.key});

  @override
  State<NotificationNewfriendScreen> createState() =>
      _NotificationNewfriendScreenState();
}

class _NotificationNewfriendScreenState
    extends State<NotificationNewfriendScreen> {
  late List<ModelUser> _fetchedFriendsRequestsUsersList = List.empty(
    growable: true,
  );
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFriendsRequestsUsersList();
  }

  Future<void> fetchFriendsRequestsUsersList() async {
    setState(() => _isLoading = true);
    final friends = await context.read<AuthProvider>().getFriendsRequests();
    setState(() {
      _fetchedFriendsRequestsUsersList = friends;
      _isLoading = false;
    });
  }

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
        actions: [
          IconButton(
            onPressed: () {
              fetchFriendsRequestsUsersList();
            },
            icon: Icon(Icons.refresh_rounded),
          ),
        ],
      ),

      body:
          _isLoading
              ? Center(child: CircularProgressIndicator())
              : _fetchedFriendsRequestsUsersList.isEmpty
              ? Center(
                child: SvBoldText(
                  text: "Nessuna richiesta di amicizia",
                  size: 16,
                  textColor: Theme.of(context).colorScheme.onSurface,
                ),
              )
              : RefreshIndicator(
                onRefresh: fetchFriendsRequestsUsersList,
                child: ListView.builder(
                  itemCount: _fetchedFriendsRequestsUsersList.length,
                  padding: EdgeInsets.only(top: 16),
                  itemBuilder: (context, index) {
                    return SvFriendrequestListtile(
                      user: _fetchedFriendsRequestsUsersList[index],
                    );
                  },
                ),
              ),
    );
  }
}
