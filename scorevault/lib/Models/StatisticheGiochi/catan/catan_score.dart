class ScoreCatan {
  final String idGiocatore;
  final int citta; //ogni città vale 2 punti
  final int colonie; //ogni colonia vale 1 punto
  final int puntiVittoria; //punti vittoria dati dalle carte
  //TODO controllo che non più di un giocatore abbia questi bonus
  final bool strada; //giocatore con strada più lunga, solo 1 a partita (5 punti)
  final bool esercito; //giocatore con esercito più grande, solo 1 a partita (5 punti)
  final int totale; //somma semplice
  

  ScoreCatan({
    required this.idGiocatore,
    required this.citta,
    required this.colonie,
    required this.puntiVittoria,
    required this.strada,
    required this.esercito,
    required this.totale,
  });

  Map<String, dynamic> toJson() {
    return {
      'idGiocatore': idGiocatore,
      'citta': citta,
      'colonie': colonie,
      'puntiVittoria': puntiVittoria,
      'stradaPiuLunga': strada,
      'esercitoPiuGrande': esercito,
      'totale': totale,
    };
  }

    //TODO aggiungiamo qui la formula per la somma?? 
}