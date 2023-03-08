//source adapté: https://www.youtube.com/watch?v=jFHSkfjN96I
import 'package:flutter/material.dart';
import 'package:projet/jeuModele.dart';
import 'package:projet/searchPage.dart';
import 'package:projet/whishlist.dart';

class pageAccueil extends StatefulWidget {
  const pageAccueil({Key? key}) : super(key: key);
  @override
  State<pageAccueil> createState() => _pageAccueil();
}

class _pageAccueil extends State<pageAccueil> {
  //initialisation d'une liste
  //a automatiser avec l'API Steam
  static List<jeuModel> list_meilleuresVentes = [
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
  //liste que l'on affiche
  List<jeuModel> affichage_listmeilleuresVentes =
      List.from(list_meilleuresVentes);

  void updatePage() {
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
          TextField(
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
          SizedBox(
            height: 20.0,
          ),
          Container(
              child: Column(
            children: [
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
                "Une description d’un jeu mis en avant\n (peu être fait en dur)",
                style: TextStyle(
                  color: Color(0xFFFFFFff),
                  fontFamily: "ProximaNova-Bold",
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => pageWishlist()),
                    );
                  },
                  child: Text("En savoir plus",
                      style: TextStyle(
                          color: Color(0xFFFFFFff),
                          fontFamily: "ProximaNova-Regular",
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ],
          )),
          Expanded(
            child: ListView.builder(
              itemCount: affichage_listmeilleuresVentes.length,
              itemBuilder: (context, index) => ListTile(
                title: Column(
                  children: [
                    Text(affichage_listmeilleuresVentes[index].jeu_titre!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.265845,
                          fontWeight: FontWeight.w400,
                          fontFamily: "ProximaNova-Regular",
                        )),
                    Text(affichage_listmeilleuresVentes[index].jeu_editeur!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "ProximaNova-Regular",
                        )),
                    Text(
                      "prix: "
                      '${affichage_listmeilleuresVentes[index].jeu_prix!}'
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
                        MaterialPageRoute(builder: (context) => pageWishlist()),
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
                    affichage_listmeilleuresVentes[index].jeu_poster_url!),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
