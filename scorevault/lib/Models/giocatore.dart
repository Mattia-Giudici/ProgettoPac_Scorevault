//TODO classe tutta da ampliare e completare, solo essenziale per ora
class Giocatore {
  final String uid;
  final String email;

  Giocatore({required this.uid, required this.email});

  factory Giocatore.fromJson(Map<String, dynamic> json) {
    return Giocatore(
      uid: json['uid'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
    };
  }
}