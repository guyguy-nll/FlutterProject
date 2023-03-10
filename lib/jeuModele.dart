//source: https://www.youtube.com/watch?v=jFHSkfjN96I
//Modèle d'un jeu
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';


class JeuModel {
  String? jeu_titre;
  String? jeu_editeur;
  String? jeu_prix;
  String? jeu_poster_url;
  JeuModel({
      this.jeu_titre, this.jeu_editeur, this.jeu_prix, this.jeu_poster_url});
}
/*
factory jeuModel.fromJson(dynamic json){
  return jeuModel(
    jeu_titre: json('name') as String,
    jeu_editeur: json ('totalTime') as String,
    jeu_prix: json['rating'] as int,
    jeu_poster_url: json ['images '] [0] ['hostedLargeUrl'] as String, 
  );
}

static List<jeuModel> recipesFromSnapshot(List snapshot){
return snapshot.map(
(data){
return jeuModel.fromJson(data);
}
).toList();
}
}
*/
/*
class JeuModel {
  final String jeu_titre;
  final String jeu_editeur;
  final String jeu_prix;
  final String jeu_poster_url;

  JeuModel({required this.jeu_titre, required this.jeu_editeur, required this.jeu_prix, required this.jeu_poster_url});
}
*/