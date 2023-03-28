//source adapté: https://www.youtube.com/watch?v=jFHSkfjN96I
// source API : https://www.youtube.com/watch?v=FlGTSb7_9jk
import 'package:flutter/material.dart';
import 'package:projet/detailJeu.dart';
import 'package:projet/jeuModele.dart';
import 'package:projet/like.dart';
import 'package:projet/searchPage.dart';
import 'package:projet/whishlist.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_svg/flutter_svg.dart';

class pageAccueil extends StatefulWidget {
  const pageAccueil({Key? key}) : super(key: key);
  @override
  State<pageAccueil> createState() => _pageAccueil();
}

class _pageAccueil extends State<pageAccueil> {
  //initialisation d'une liste
  //a automatiser avec l'API Steam
  List<JeuModel> list_meilleuresVentes = [];

  //liste que l'on affiche

  bool _isLoading = true;
  //pour le chargement de l'API

  Future<void> getJeux() async {
    print('Lecture API');
    List<String> appIds = await loadGames();

    //final String apiKey = '543CB15FFA49C7D4EAF4E917BBCC12B9';

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
        final String jeu_prix;
        final String jeu_poster_url = data['header_image'];
        final int jeu_id = data['steam_appid'];

        if (data.containsKey('price_overview')) {
          jeu_prix = data['price_overview']['final_formatted'];
        } else {
          jeu_prix = '0 €';
        }

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

  Future<List<String>> loadGames() async {
    final response = await http.get(
      Uri.parse(
          'https://api.steampowered.com/ISteamChartsService/GetMostPlayedGames/v1/?'),
    );

    if (response.statusCode == 200) {
      try {
        Map json = jsonDecode(response.body);
        List<dynamic> ranks = json['response']['ranks'] as List<dynamic>;
        List<String> appIds = [];
        for (var i = 0; i < ranks.length; i++) {
          Map rank = ranks[i];
          appIds.add(rank['appid'].toString());
        }
        return appIds;
      } catch (err) {
        print(err);
        return [];
      }
    } else {
      throw Exception(
          'Failed to load most played games: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    print('Init');
    super.initState();
    loadGames();
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
    // affichage d'un widget de chargement tant que les données ne sont pas disponibles
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      backgroundColor: Color(0xff1A2026),
      appBar: AppBar(
        backgroundColor: Color(0xff1E262B),
        elevation: 0.0,
        centerTitle: false,
        title: Text(
          "Accueil",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: "GoogleSans-Bold",
          ),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/like.svg',
              width: 20.0,
              height: 20.0,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pageLike()),
                );
              });
            },
          ),
          SizedBox(width: 30.0),
          IconButton(
            icon: SvgPicture.asset(
              'assets/images/whishlist.svg',
              width: 20.0,
              height: 20.0,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pageWish()),
                );
              });
            },
          ),
          SizedBox(width: 10.0),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => pageRecherche()),
                  );
                });
              },
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color(0xff1F262C),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Rechercher un jeu…",
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12.9172535,
                  fontWeight: FontWeight.w400,
                  fontFamily: "ProximaNova-Regular",
                ),
                suffixIcon: Icon(Icons.search),
                suffixIconColor: Color(0xFF636af6),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            //source pour affichage image:https://stackoverflow.com/questions/44179889/how-do-i-set-background-image-in-flutter
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/backgroundtitan2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Titan Fall 2\n Ultimate Edition",
                      style: TextStyle(
                        color: Color(0xFFFFFFff),
                        fontFamily: "ProximaNova-Bold",
                        fontSize: 18.788733,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "   Une description d’un jeu mis en avant\n (peu être fait en dur)",
                      style: TextStyle(
                        color: Color(0xFFFFFFff),
                        fontFamily: "ProximaNova-Regular",
                        fontSize: 11.742958,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: 162.99,
                      height: 35.23,
                      child: RawMaterialButton(
                        fillColor: Color(0xFF636af6),
                        elevation: 0.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3.52)),
                        onPressed: () {},
                        child: Text("En savoir plus",
                            style: TextStyle(
                                color: Color(0xFFFFFFff),
                                fontFamily: "ProximaNova-Regular",
                                fontSize: 12,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
                SizedBox(
                  width: 50.0,
                ),
                Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmoyK7ptpmDEkYLrtIezYYRtKWUDsvS68gjg&usqp=CAU',
                  width: 102.16,
                  height: 125.65,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Les meilleures ventes",
              style: TextStyle(
                color: Color(0xFFFFFFff),
                fontFamily: "ProximaNova-Regular",
                fontSize: 15.265845,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: list_meilleuresVentes.length,
                itemBuilder: (context, index) => Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.17),
                  ),
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: ColoredBox(
                        color: Color(0xFF232C34),
                      )),
                      Container(
                        height: 102,
                        width: double.infinity,
                        child: Opacity(
                          opacity: 0.5,
                          child: Image.asset(
                            'assets/images/destinytransparent.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 10.0,
                          ),
                          Image.network(
                            list_meilleuresVentes[index].jeu_poster_url!,
                            width: 63,
                            height: 79,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 10.0,
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
                                      text: "Prix:",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "ProximaNova-Regular",
                                        decoration: TextDecoration.underline,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: " "
                                              '${list_meilleuresVentes[index].jeu_prix!}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "ProximaNova-Regular",
                                            decoration: TextDecoration.none,
                                          ),
                                        ),
                                      ]),
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
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
