import 'package:scorevault/Models/StatisticheGiochi/7wonders/7wonders_score.dart';
import 'package:scorevault/Models/model_user.dart';

class SevenWonders{
  final String gameId;
  final DateTime date;
  final List<ModelUser> giocatori;
  final Map<String, Score7Wonders> scores; 

  SevenWonders({
    required this.gameId,
    required this.date,
    required this.giocatori,
    required this.scores,
  });

  Map<String, dynamic> toJson() {
    return {
      'gameId': gameId,
      'date': date.toIso8601String(),
      'scores': scores.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}
