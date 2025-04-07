import 'package:flutter/material.dart';
import 'package:scorevault/utils/colors.dart';
import 'package:scorevault/views/screens/homepage/tabs/tab_crono.dart';
import 'package:scorevault/views/screens/homepage/tabs/tab_games.dart';
import 'package:scorevault/views/screens/homepage/tabs/tab_account.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomepagScreenState();
}

class _HomepagScreenState extends State<HomePageScreen> {
  int _selectedIndex = 0;

  final List<Widget> _listaTabs = [TabGames(), TabCrono(),TabAccount()];

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          // const HeaderWidget(),
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
        selectedItemColor: AppColors.lightPrimary,
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
