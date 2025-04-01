import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scorevault/views/widgets/cards/game_card.dart';

class TabGames extends StatelessWidget {
  final List<Map<String, String>> games = [
    {'name': '7 Wonders', 'image': 'assets/7wonders.jpg'},
    {'name': 'Coloni di Catan', 'image': 'assets/catan.jpg'},
    {'name': 'Burraco', 'image': 'assets/burraco.jpg'},
    {'name': 'Lost Cities', 'image': 'assets/lostcities.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: games.length,
      itemBuilder: (context, index) {
        return GameCardWidget(
          gameName: games[index]['name']!,
          imageName: games[index]['image']!,
          //TODO dati da aggiornare con il database
          elo: 0, 
          matchesPlayed: 0,
          matchesWon: 0,
        );
      },
    );
  }
}
