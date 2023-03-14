//source adapté: https://www.youtube.com/watch?v=jFHSkfjN96I
import 'package:flutter/material.dart';
import 'package:projet/jeuModele.dart';
import 'package:projet/whishlist.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class pageRecherche extends StatefulWidget {
  const pageRecherche({Key? key}) : super(key: key);
  @override
  State<pageRecherche> createState() => _pageRecherche();
}

class _pageRecherche extends State<pageRecherche> {
  //initialisation d'une liste
  //a automatiser avec l'API Steam
   

  @override
  void initState() {
    super.initState();
    getJeux();
  }

  static List<JeuModel> list_jeu = [];

  Future<void> getJeux() async {
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
          list_jeu.add(jeu);
        });
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }
  }
  /*
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des jeux'),
      ),
      body: ListView.builder(
        itemCount: list_jeu.length,
        itemBuilder: (BuildContext context, int index) {
          final jeu = list_jeu[index];
          return ListTile(
            leading: Image.network(jeu.image),
            title: Text(jeu.name),
            subtitle: Text('${jeu.publisher} | ${jeu.price}'),
          );
        },
      ),
    );
  }
  */

  /*
  static List<jeuModel> list_jeu = [
    jeuModel("GTA V", "paul bernard", 13,
        "https://media-rockstargames-com.akamaized.net/rockstargames-newsite/img/global/games/fob/1280/V.jpg"),
    jeuModel("Fortnite", "Madame Salade", 17,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJmwo-EMVe3bpGcYJUHtUBDTSHkiMqwatA5Q&usqp=CAU"),
    jeuModel("Fifa 2023", "Madame Banane", 11,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd5Ilu1hZiTWi_wwoPmbWIsqUN-2Q4-gq-lA&usqp=CAU"),
    jeuModel("Schrtoumpfs", "Monsieur Kart", 12,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuEWTQEQ5DzeLCzNzQyq-aT2_WXCJ7mMpXkg&usqp=CAU"),
    jeuModel("Mario", "Monsieur Andive", 19,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQE4tG47ov5EpSQ7mN4p2qfnIvG5lrLQmVmog&usqp=CAU"),
    jeuModel("Human Fall", "Martin", 11,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSg8x3Gk679bDQfOlkAvjjCkBl8HHHNgLtJWQ&usqp=CAU"),
    jeuModel("Supermash", "Bro", 7,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHuo-L8Sg8HR6OlZWRsS3fNK5Hcbujg2fLvw&usqp=CAU"),
    jeuModel("Chim Party", "Patate", 12,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpFWnvUiLfVxet8bmy-a2tEymqRpn-NeYE_g&usqp=CAU"),
    jeuModel("Tanaki Justice", "Bernard", 14,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9e-vY91PzDKNMrCKCNNpZbtIUYEhN31XRVA&usqp=CAU"),
    jeuModel("Megaman", "Etoile", 18,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRs6NMAvupGjYYMYT-FbR7OC8nwR6qhNbiZBA&usqp=CAU"),
  ];
  */
  //liste que l'on affiche
  List<JeuModel> affichage_list = List.from(list_jeu);

  void updateList(String saisie) {
    //ajuste la List en fonction de la recherche
    setState(() {
      affichage_list = list_jeu
          .where((eLement) =>
              eLement.jeu_titre!.toLowerCase().contains(saisie.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text(
          "Recherche",
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
            TextField(
              onChanged: (value) => updateList(value),
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
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: affichage_list.length,
                itemBuilder: (context, index) => ListTile(
                  title: Column(
                    children: [
                      Text(affichage_list[index].jeu_titre!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.265845,
                            fontWeight: FontWeight.w400,
                            fontFamily: "ProximaNova-Regular",
                          )),
                      Text(affichage_list[index].jeu_editeur!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "ProximaNova-Regular",
                          )),
                      Text(
                        "prix: "
                        '${affichage_list[index].jeu_prix!}'
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
                          MaterialPageRoute(
                              builder: (context) => pageWish()),
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
                  leading: Image.network(affichage_list[index].jeu_poster_url!),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
