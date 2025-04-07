import 'package:flutter/material.dart';
import 'package:scorevault/views/screens/generic_games/game_screen.dart';

class GameCardWidget extends StatelessWidget {
  final String gameName;
  final String imageName;
  final int elo;
  final int matchesPlayed;
  final int matchesWon;

  const GameCardWidget({
    super.key,
    required this.gameName,
    required this.imageName,
    required this.elo,
    required this.matchesPlayed,
    required this.matchesWon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        //TODO questo è temporaneo, volevo solo metterlo per ricordami l'idea, non voglio mettere il pop-up ma vorrei che le scritte 
        //apparissero sopra l'immagine del gioco
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(gameName),
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
        // TODO Navigazione alla pagina del gioco 
         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => GameScreen(gameName: gameName,)),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16), 
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                imageName,
                fit: BoxFit.cover,
              ),
            ),

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
            // TESTO NOME GIOCO
            Positioned(
              top: 10,
              left: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  gameName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
              padding: const EdgeInsets.symmetric(horizontal:55, vertical: 5),
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
