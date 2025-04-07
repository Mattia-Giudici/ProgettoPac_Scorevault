import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/Models/model_user.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/widgets/listtiles/sv_friendrequest_listtile.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';
import 'package:scorevault/views/widgets/texts/sv_standard_text.dart';

class NewfriendsScreen extends StatefulWidget {
  const NewfriendsScreen({super.key});

  @override
  State<NewfriendsScreen> createState() => _NewfriendsScreenState();
}

class _NewfriendsScreenState extends State<NewfriendsScreen> {
  String searchQuery = '';
  List<ModelUser> allUsers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final stream = context.read<AuthProvider>().getAllUsersExceptCurrentUserAndFriendsAndPending();
    stream.listen((users) {
      setState(() {
        if (mounted) {  
          allUsers = users;
          isLoading = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = allUsers.where((user) {
      final name = user.getUsername.toLowerCase();
      final email = user.getEmail.toLowerCase();
      return name.contains(searchQuery.toLowerCase()) ||
             email.contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        title: SvBoldText(
          text: "Nuove amicizie",
          size: 24,
          textColor: AppColors.lightSurface,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Column(
        children: [
          AppBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            toolbarHeight: 90,
            automaticallyImplyLeading: false,
            title: TextField(
              onChanged: (value) {
                setState(() {
                  if (mounted) {
                    searchQuery = value.trim();
                  }
                });
              },
              style: SvStandardText.getTextStyle(
                size: 16,
                textColor: Theme.of(context).colorScheme.onSurface,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Theme.of(context).colorScheme.primaryContainer,
                hintText: "Cerca",
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(16),
                ),
                prefixIcon: Icon(Icons.search_rounded),
                
              ),
              
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : filteredUsers.isEmpty
                    ? Center(
                        child: SvBoldText(
                          text: "Nessun utente trovato",
                          size: 16,
                          textColor: Theme.of(context).colorScheme.onSurface,
                        ),
                      )
                    : ListView.builder(
                        itemCount: filteredUsers.length,
                        itemBuilder: (context, index) {
                          return SvFriendrequestListtile(
                            user: filteredUsers[index],
                            isRequestSent: false,
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
