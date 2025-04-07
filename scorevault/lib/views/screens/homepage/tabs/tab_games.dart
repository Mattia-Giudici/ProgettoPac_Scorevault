import 'package:flutter/material.dart';
import 'package:scorevault/views/widgets/cards/game_card.dart';
//TODO Categorie e filtri  UC2
//TODO giochi preferiti 

class TabGames extends StatefulWidget {
  TabGames({super.key});
  @override
  _TabGamesState createState() => _TabGamesState();
}

class _TabGamesState extends State<TabGames> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, String>> _allGames = [
    {'name': '7 Wonders', 'image': 'assets/7wonders.jpg'},
    {'name': 'Coloni di Catan', 'image': 'assets/catan.jpg'},
    {'name': 'Burraco', 'image': 'assets/burraco.jpg'},
    {'name': 'Lost Cities', 'image': 'assets/lostcities.jpg'},
  ];
  List<Map<String, String>> _filteredGames = [];

  @override
  void initState() {
    super.initState();
    _filteredGames = _allGames; // Mostra tutti i giochi inizialmente
  }

  void _filterGames(String query) {
    setState(() {
      _filteredGames = _allGames
          .where((game) =>
              game['name']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
        controller: _searchController,
        onChanged: _filterGames,
        decoration: InputDecoration(
          hintText: 'Cerca giochi...',
          prefixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary, size: 30.0),
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20.0),
          filled: true,
          fillColor: Theme.of(context).colorScheme.primaryContainer,
            border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60.0),
            borderSide: BorderSide.none,
            ),
          ),
            ),
          ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: _filteredGames.length,
            itemBuilder: (context, index) {
              return GameCardWidget(
                gameName: _filteredGames[index]['name']!,
                imageName: _filteredGames[index]['image']!,
                // TODO: dati da aggiornare con il database
                elo: 0,
                matchesPlayed: 0,
                matchesWon: 0,
              );
            },
          ),
        ),
      ],
    );
  }
}