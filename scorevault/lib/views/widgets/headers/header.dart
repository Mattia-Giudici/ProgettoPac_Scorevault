
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            flex: 2,
            child: Text(
              "ELO: 1500",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.person, size: 32),
            onPressed: () {
              // Azione per aprire le info utente
            },
          ),
        ],
      ),
    );
  }
}
