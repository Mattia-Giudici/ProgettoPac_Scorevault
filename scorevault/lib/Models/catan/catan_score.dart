class ScoreCatan {
  final String idGiocatore;
  final int citta;
  final int colonie;
  final int puntiVittoria;
  //TODO controllo che non più di un giocatore abbia questi bonus
  final bool strada; //giocatore con strada più lunga, solo 1 a partita
  final bool esercito; //giocatore con esercito più grande, solo 1 a partita
  

  ScoreCatan({
    required this.idGiocatore,
    required this.citta,
    required this.colonie,
    required this.puntiVittoria,
    required this.strada,
    required this.esercito,
  });

  Map<String, dynamic> toJson() {
    return {
      'idGiocatore': idGiocatore,
      'citta': citta,
      'colonie': colonie,
      'puntiVittoria': puntiVittoria,
      'stradaPiuLunga': strada,
      'esercitoPiuGrande': esercito,
    };
  }
}