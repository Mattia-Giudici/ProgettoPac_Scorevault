import 'package:flutter/material.dart';
import 'package:scorevault/views/screens/homepage/homepag_screen.dart';

//TODO UC2.2 pagina generica del gioco, descrizione, categorie, difficoltà, durata, numero giocatori, preferiti
class GameScreen extends StatelessWidget {
  final String gameName;

  const GameScreen({super.key, required this.gameName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gameName)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pagina in costruzione per $gameName',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePageScreen()),
                );
              },
              child: Text('Torna alla Homepage'),
            ),
          ],
        ),
      ),
    );
  }
}
