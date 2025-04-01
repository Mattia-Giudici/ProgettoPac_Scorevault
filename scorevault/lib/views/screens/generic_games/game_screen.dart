import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GameScreen extends StatelessWidget {
  final String gameName;

  const GameScreen({super.key, required this.gameName});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(gameName),
        ),
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
                  context.go('/home');
                },
                child: Text('Torna alla Homepage'),
              ),
            ],
          ),
        ),
      );
    }
  }
