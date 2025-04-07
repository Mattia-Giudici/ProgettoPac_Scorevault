import 'package:scorevault/Models/burraco/burraco_mano.dart';
import 'package:scorevault/Models/model_user.dart';
//TODO bozza 
class Burraco {
  final String id;
  final DateTime data;
  final List<ModelUser> giocatori;
  final String modalita; // "finale" o "dettagliata"
  final Map<String, int>? punteggiFinali;
  final List<ManoBurraco>? dettagliMani;

  Burraco({
    required this.id,
    required this.data,
    required this.giocatori,
    required this.modalita,
    this.punteggiFinali,
    this.dettagliMani,
  });

  factory Burraco.fromJson(Map<String, dynamic> json) {
    return Burraco(
      id: json['id'],
      data: DateTime.parse(json['data']),
      giocatori: (json['giocatori'] as List)
          .map((g) => ModelUser.fromJson(g))
          .toList(),
      modalita: json['modalita'],
      punteggiFinali: json['punteggi_finali'] != null
          ? Map<String, int>.from(json['punteggi_finali'])
          : null,
      dettagliMani: json['dettagli_mani'] != null
          ? (json['dettagli_mani'] as List)
              .map((m) => ManoBurraco.fromJson(m))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'data': data.toIso8601String(),
      'giocatori': giocatori.map((g) => g.toJson()).toList(),
      'modalita': modalita,
      'punteggi_finali': punteggiFinali,
      'dettagli_mani': dettagliMani?.map((m) => m.toJson()).toList(),
    };
  }
}

