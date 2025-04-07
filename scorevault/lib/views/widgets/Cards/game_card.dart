import 'package:flutter/material.dart';
import 'package:scorevault/models/game_info.dart';
import 'package:scorevault/views/screens/generic_games/game_screen.dart';

class GameCardWidget extends StatelessWidget {
  final GameInfo game;
  final int elo;
  final int matchesPlayed;
  final int matchesWon;

  const GameCardWidget({
    super.key,
    required this.game,
    required this.elo,
    required this.matchesPlayed,
    required this.matchesWon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(game.nome),
              content: Text("Partite giocate: $matchesPlayed\nVittorie: $matchesWon"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Chiudi"),
                ),
              ],
            );
          },
        );
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => GameScreen(gameName: game.nome)),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // IMMAGINE DEL GIOCO
            Positioned.fill(
              child: Image.asset(
                game.immagine,
                fit: BoxFit.cover,
              ),
            ),

            // GRADIENTE SUPERIORE PER TESTO
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.white70,
                      Colors.white10,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // NOME DEL GIOCO
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  game.nome,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            // ELO (in basso centrato)
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 5),
                child: Text(
                  "ELO: $elo",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
