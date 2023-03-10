//source adapté: https://www.youtube.com/watch?v=jFHSkfjN96I
import 'package:flutter/material.dart';
import 'package:projet/detailJeu.dart';
import 'package:projet/jeuModele.dart';
import 'package:projet/searchPage.dart';
import 'package:projet/whishlist.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
    
    //final String apiKey = '543CB15FFA49C7D4EAF4E917BBCC12B9';
    final List<String> appIds = ['570', '730', '1091500', '570940', '583950'];

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

        final JeuModel jeu =
            JeuModel(jeu_titre: jeu_titre, jeu_editeur: jeu_editeur, jeu_prix: jeu_prix, jeu_poster_url: jeu_poster_url);
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
    // affichage d'un widget de chargement tant que les données ne sont pas disponibles
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
          "Accueil",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: "GoogleSans-Bold",
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (value) => updatePage(),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 29, 28, 28),
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
            padding: EdgeInsets.all(16.0),
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
            child: ListView.builder(
              itemCount: list_meilleuresVentes.length,
              itemBuilder: (context, index) => ListTile(
                title: Column(
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
                    Text(
                      "prix: "
                      '${list_meilleuresVentes[index].jeu_prix!}'
                      "€",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        fontFamily: "ProximaNova-Regular",
                      ),
                    ),
                  ],
                ),
                trailing: Container(
                  width: 100.99,
                  child: RawMaterialButton(
                    fillColor: Color(0xFF636af6),
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.52)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => pageDetail()),
                      );
                    },
                    child: Text("En savoir \n plus",
                        style: TextStyle(
                            color: Color(0xFFFFFFff),
                            fontFamily: "ProximaNova-Regular",
                            fontSize: 18.788733,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                leading: Image.network(
                    list_meilleuresVentes[index].jeu_poster_url!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
