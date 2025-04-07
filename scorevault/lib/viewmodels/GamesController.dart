import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scorevault/models/game_info.dart';

class GamesController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<GameInfo>> fetchGames() async {
    try {
      final snapshot = await _firestore.collection('giochi').get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return GameInfo.fromJson(data);
      }).toList();
    } catch (e) {
      throw Exception('Errore nel recupero dei giochi');
    }
  }
}
