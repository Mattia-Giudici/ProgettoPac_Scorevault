import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:scorevault/viewmodels/providers/auth_provider.dart';
import 'package:scorevault/views/screens/homepage/tabs/tab_account.dart';
import 'package:scorevault/views/screens/homepage/tabs/tab_games.dart';
import 'package:scorevault/views/widgets/texts/sv_bold_text.dart';

class HomepagScreen extends StatefulWidget {
  const HomepagScreen({super.key});

  @override
  State<HomepagScreen> createState() => _HomepagScreenState();
}

class _HomepagScreenState extends State<HomepagScreen> {
  late final AuthProvider _authProvider;
  int _selectedIndex = 0;

  List<Widget> _listaTabs = [TabGames(), TabAccount()];

  @override
  void initState() {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: _listaTabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        
        onTap: (value) {
          setState(() {
            _selectedIndex = value;
          });
        },
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: SvBoldText.getTextStyle(size: 12, textColor: Theme.of(context).colorScheme.onSurface),
                selectedLabelStyle: SvBoldText.getTextStyle(size: 12, textColor: Theme.of(context).colorScheme.primary),

        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.gamepad_rounded),
            label: 'Giochi',
        
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
