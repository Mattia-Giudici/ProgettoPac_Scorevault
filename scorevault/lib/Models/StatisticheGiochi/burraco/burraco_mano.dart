import 'package:scorevault/Models/StatisticheGiochi/burraco/burraco_score.dart';
//TODO bozza 
class ManoBurraco {
  final int numero;
  final Map<String, ScoreBurraco> punteggi;

  ManoBurraco({required this.numero, required this.punteggi});

  factory ManoBurraco.fromJson(Map<String, dynamic> json) {
    return ManoBurraco(
      numero: json['numero'],
      punteggi: (json['punteggi'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, ScoreBurraco.fromJson(value)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'numero': numero,
      'punteggi': punteggi.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

