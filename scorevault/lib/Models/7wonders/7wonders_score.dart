class Score7Wonders {
  final String playerId;
  final int meraviglie;
  final int monete;
  final int militare;
  final int civile;
  final int commerciale;
  final int scienze;
  final int gilde;
  final int totale;

  Score7Wonders({
    required this.playerId,
    required this.meraviglie,
    required this.monete,
    required this.militare,
    required this.civile,
    required this.commerciale,
    required this.scienze,
    required this.gilde,
    required this.totale,
  });

  Map<String, dynamic> toJson() {
    return {
      'playerId': playerId,
      'wonderPoints': meraviglie,
      'coins': monete,
      'military': militare,
      'civilBuildings': civile,
      'commercialBuildings': commerciale,
      'science': scienze,
      'guilds': gilde,
      'total': totale,
    };
  }
  //TODO aggiungiamo qui la formula per la somma?? 
}
