//source adapté: https://www.youtube.com/watch?v=jFHSkfjN96I
import 'package:flutter/material.dart';
import 'package:projet/jeuModele.dart';

class searchPage extends StatelessWidget {
  //initialisation d'une liste
  //a automatiser avec l'API Steam
  static List<jeuModel> list_jeu = [
    jeuModel("GTA V", "paul bernard", 13,
        "https://media-rockstargames-com.akamaized.net/rockstargames-newsite/img/global/games/fob/1280/V.jpg"),
    jeuModel("Fortnite", "Madame Salade", 17,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJmwo-EMVe3bpGcYJUHtUBDTSHkiMqwatA5Q&usqp=CAU"),
    jeuModel("Fifa 2023", "Madame Banane", 11,
        "https://www.google.com/imgres?imgurl=https%3A%2F%2Fchocobonplan.com%2Fwp-content%2Fuploads%2F2022%2F07%2Ffifa-23-visuel-produit-ps4-def-300x300.png&imgrefurl=https%3A%2F%2Fchocobonplan.com%2Fbons-plans%2Fjeux-video-pas-cher%2Fjeux-ps4-pas-cher%2Ffifa-23-sur-ps4%2F&tbnid=DV9Pr7z6y9U03M&vet=12ahUKEwij8ey7qML9AhX4TaQEHUnQAxwQMygIegUIARCaAw..i&docid=HDtvojGeKf1q-M&w=300&h=300&q=fifa2023%20jeu%20ps4&ved=2ahUKEwij8ey7qML9AhX4TaQEHUnQAxwQMygIegUIARCaAw"),
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
  List<jeuModel> affichage_list = List.from(list_jeu);

  void updateList(String saisie) {
    //ajuste la List en fonction de la recherche
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recherche",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w400,
                fontFamily: "GoogleSans-Bold",
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
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
                        '${affichage_list[index].jeu_prix!}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          fontFamily: "ProximaNova-Regular",
                        ),
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
