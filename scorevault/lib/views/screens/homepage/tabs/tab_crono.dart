import 'package:flutter/material.dart';
import 'package:scorevault/views/screens/homepage/homepag_screen.dart';

//TODO pagina con la cronologia di tutte le ultime partite giocate, aggiunta di filtri???
class TabCrono extends StatelessWidget {
  const TabCrono({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pagina in costruzione per la tua cronologia',
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
