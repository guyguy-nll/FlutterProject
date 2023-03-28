import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class AvisModel {
  String? avis_description;
  double? avis_etoile;
  int? jeu_id;
  AvisModel({
    this.avis_description,
    this.avis_etoile,
    this.jeu_id,
  });
}
