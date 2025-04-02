import 'package:scorevault/Models/catan/catan_score.dart';
import 'package:scorevault/Models/giocatore.dart';

class Catan {
  final String idPartita;
  final DateTime data;
  final List<Giocatore> giocatori;
  final Map<String, ScoreCatan> punteggi;

  Catan({
    required this.idPartita,
    required this.data,
    required this.giocatori,
    required this.punteggi,
  });

  Map<String, dynamic> toJson() {
    return {
      'idPartita': idPartita,
      'data': data.toIso8601String(),
      'punteggi': punteggi.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

