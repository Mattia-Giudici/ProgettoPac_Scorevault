import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/screens/homepage/tabs/tab_crono.dart';
import 'package:scorevault/views/screens/homepage/tabs/tab_games.dart';
import 'package:scorevault/views/screens/homepage/tabs/tab_account.dart';
import 'package:scorevault/views/widgets/headers/header_home.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomepagScreenState();
}

class _HomepagScreenState extends State<HomePageScreen> {
  late final AuthProvider _authProvider;
  int _selectedIndex = 0;

  final List<Widget> _listaTabs = [TabGames(), TabCrono(),TabAccount()];

  @override
  void initState() {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
           const HeaderWidget(),
          Expanded(
            child: _listaTabs[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad_rounded),
            label: 'Giochi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history), 
            label: 'Cronologia'),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Account',
          ),
          
        ],
      ),
    );
  }
}
