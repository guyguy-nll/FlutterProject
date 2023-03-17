//source adapté: https://www.youtube.com/watch?v=jFHSkfjN96I
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:projet/detailJeu.dart';
import 'package:projet/jeuModele.dart';
import 'package:projet/searchPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

class pageWish extends StatefulWidget {
  const pageWish({Key? key}) : super(key: key);
  @override
  State<pageWish> createState() => _pageWish();
}

class _pageWish extends State<pageWish> {
  //initialisation d'une liste
  //a automatiser avec l'API Steam
  List<JeuModel> list_meilleuresVentes = [];
  //liste que l'on affiche

  bool _isLoading = true;
  //pour le chargement de l'API

  Future<void> getJeux() async {
    print('Lecture API');

    //final String apiKey = '543CB15FFA49C7D4EAF4E917BBCC12B9';
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
  final userData = await FirebaseFirestore.instance.collection('Users').doc(user!.uid).get();
  final Map<String, dynamic> wishlist = userData.data()!['wishlist'] ?? {};
  List<String> likedGames = [];

  wishlist.forEach((key, value) {
    likedGames.add(key);
  });

    //final List<String> appIds = ['570', '730', '1091500', '570940', '583950'];
    final List<String> appIds = likedGames;
    appIds.forEach((element) {
  print(element);
});

    for (var i = 0; i < appIds.length; i++) {
      final String url =
          'https://store.steampowered.com/api/appdetails/?appids=${appIds[i]}&key=543CB15FFA49C7D4EAF4E917BBCC12B9&json=1';

      final response = await http.get(Uri.parse(url), headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
      });

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final data = jsonResponse[appIds[i]]['data'];

        final String jeu_titre = data['name'];
        final String jeu_editeur = data['publishers'][0];
        final String jeu_prix = data['type'];
        final String jeu_poster_url = data['header_image'];
        final int jeu_id = data['steam_appid'];

        final JeuModel jeu = JeuModel(
            jeu_titre: jeu_titre,
            jeu_editeur: jeu_editeur,
            jeu_prix: jeu_prix,
            jeu_poster_url: jeu_poster_url,
            jeu_id: jeu_id);
        setState(() {
          list_meilleuresVentes.add(jeu);
        });
      } else {
        print('Erreur: ${response.statusCode}.');
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    print('Init');
    super.initState();
    getJeux();
  }

  void updatePage() {
    print('Update');
    //ajuste la List en fonction de la recherche
    setState(() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pageRecherche()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text(
          "Ma Wishlist",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: "GoogleSans-Bold",
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
            height: 10.0,
          ),
            Expanded(
              child: ListView.builder(
                itemCount: list_meilleuresVentes.length,
                itemBuilder: (context, index) => Card(
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: ColoredBox(
                            color: Colors.black,
                          )),
                      Row(
                        children: [
                          Image.network(
                            list_meilleuresVentes[index].jeu_poster_url!,
                            width: 63,
                            height: 79,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(list_meilleuresVentes[index].jeu_titre!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.265845,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "ProximaNova-Regular",
                                    )),

                                Text(list_meilleuresVentes[index].jeu_editeur!,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "ProximaNova-Regular",
                                    )),
                                SizedBox(
                                  height: 5.0,
                                ),
                                RichText(
                                  text: TextSpan(
                                      text: "Prix: ",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "ProximaNova-Regular",
                                        decoration: TextDecoration.underline,
                                      ),
                                      children:[
                                        TextSpan(
                                          text: '${list_meilleuresVentes[index].jeu_prix!}'
                                              "€",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "ProximaNova-Regular",
                                            decoration: TextDecoration.none,
                                          ),
                                        ),]
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 102,
                            width: 100.99,
                            child: RawMaterialButton(
                              fillColor: Color(0xFF636af6),
                              elevation: 0.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.52)),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => pageDetail(
                                          jeuId: list_meilleuresVentes[index]
                                              .jeu_id!)),
                                );
                              },
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("En savoir",
                                        style: TextStyle(
                                            color: Color(0xFFFFFFff),
                                            fontFamily: "ProximaNova-Regular",
                                            fontSize: 18.788733,
                                            fontWeight: FontWeight.w400)),
                                    Text("plus",
                                        style: TextStyle(
                                            color: Color(0xFFFFFFff),
                                            fontFamily: "ProximaNova-Regular",
                                            fontSize: 18.788733,
                                            fontWeight: FontWeight.w400)),

                                  ],),),

                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
