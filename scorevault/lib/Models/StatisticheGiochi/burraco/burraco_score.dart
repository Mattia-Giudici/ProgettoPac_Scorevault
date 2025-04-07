//TODO bozza 
class ScoreBurraco {
  final int burrachiPuri;
  final int burrachiSpuri;
  final int burrachiNormali;
  final bool chiusura;
  final int puntiCarte;

  ScoreBurraco({
    required this.burrachiPuri,
    required this.burrachiSpuri,
    required this.burrachiNormali,
    required this.chiusura,
    required this.puntiCarte,
  });

  factory ScoreBurraco.fromJson(Map<String, dynamic> json) {
    return ScoreBurraco(
      burrachiPuri: json['burrachi_puri'],
      burrachiSpuri: json['burrachi_spuri'],
      burrachiNormali: json['burrachi_normali'],
      chiusura: json['chiusura'],
      puntiCarte: json['punti_carte'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'burrachi_puri': burrachiPuri,
      'burrachi_spuri': burrachiSpuri,
      'burrachi_normali': burrachiNormali,
      'chiusura': chiusura,
      'punti_carte': puntiCarte,
    };
  }
}
