import 'package:scorevault/Models/catan/catan_score.dart';

class Catan {
  final String idPartita;
  final DateTime data;
  final Map<String, ScoreCatan> punteggi;

  Catan({
    required this.idPartita,
    required this.data,
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

