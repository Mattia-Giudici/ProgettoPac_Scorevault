import 'package:scorevault/Models/7wonders/7wonders_score.dart';

class SevenWonders{
  final String gameId;
  final DateTime date;
  final Map<String, Score7Wonders> scores; 

  SevenWonders({
    required this.gameId,
    required this.date,
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
