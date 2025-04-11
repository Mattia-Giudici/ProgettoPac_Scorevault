class GameInfo {
  final String id;
  final String nome;
  final String descrizione;
  final String immagine;
  final int minPlayers;
  final int maxPlayers;
  final int durata; // valore in minuti
  final int difficulty; // Valore da 0 a 5 (rappresentato con stelle)
  final List<String> categorie;
  final List<String> modalita; // es. singolo, squadra
  final int eta; //il valore è numerico ma si riferisce sempre da quell'eta in poi es: 10+

  GameInfo({
    required this.id,
    required this.nome,
    required this.descrizione,
    required this.immagine,
    required this.minPlayers,
    required this.maxPlayers,
    required this.durata,
    required this.difficulty,
    required this.categorie,
    required this.modalita,
    required this.eta,
  });

  factory GameInfo.fromJson(Map<String, dynamic> json) {
    return GameInfo(
      id: json['id'],
      nome: json['nome'],
      descrizione: json['descrizione'],
      immagine: json['immagine'],
      minPlayers: json['min_giocatori'],
      maxPlayers: json['max_giocatori'],
      durata: json['durata_media'],
      difficulty: json['difficulty'],
      categorie: List<String>.from(json['categorie']),
      modalita: List<String>.from(json['modalita']),
      eta: json['eta'] ?? 3, //valore di default se non presente
    );
  }

//TODO potrebbe essere rimosso credo, inutile ad ora
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'descrizione': descrizione,
      'immagine': immagine,
      'min_giocatori': minPlayers,
      'max_giocatori': maxPlayers,
      'durata_media': durata,
      'difficulty': difficulty,
      'categorie': categorie,
      'modalita': modalita,
      'eta': eta,
    };
  }
}
