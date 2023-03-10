//source adapté: https://www.youtube.com/watch?v=jFHSkfjN96I
import 'package:flutter/material.dart';
import 'package:projet/jeuModele.dart';
import 'package:projet/like.dart';

class pageWishlist extends StatefulWidget {
  const pageWishlist({Key? key}) : super(key: key);
  @override
  State<pageWishlist> createState() => _pageWishlist();
}

class _pageWishlist extends State<pageWishlist> {
  //initialisation d'une liste
  //a automatiser avec l'API Steam
  static List<JeuModel> list_wish = [
    /*
    JeuModel("GTA V", "paul bernard", "13",
        "https://media-rockstargames-com.akamaized.net/rockstargames-newsite/img/global/games/fob/1280/V.jpg"),
    JeuModel("Fortnite", "Madame Salade", "17",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRJmwo-EMVe3bpGcYJUHtUBDTSHkiMqwatA5Q&usqp=CAU"),
    JeuModel("Fifa 2023", "Madame Banane", "11",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd5Ilu1hZiTWi_wwoPmbWIsqUN-2Q4-gq-lA&usqp=CAU"),
    JeuModel("Schrtoumpfs", "Monsieur Kart", "12",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuEWTQEQ5DzeLCzNzQyq-aT2_WXCJ7mMpXkg&usqp=CAU"),
    JeuModel("Mario", "Monsieur Andive", "19",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQE4tG47ov5EpSQ7mN4p2qfnIvG5lrLQmVmog&usqp=CAU"),
    JeuModel("Human Fall", "Martin", "11",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSg8x3Gk679bDQfOlkAvjjCkBl8HHHNgLtJWQ&usqp=CAU"),
    JeuModel("Supermash", "Bro", "7",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHuo-L8Sg8HR6OlZWRsS3fNK5Hcbujg2fLvw&usqp=CAU"),
    JeuModel("Chim Party", "Patate", "12",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQpFWnvUiLfVxet8bmy-a2tEymqRpn-NeYE_g&usqp=CAU"),
    JeuModel("Tanaki Justice", "Bernard", "14",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9e-vY91PzDKNMrCKCNNpZbtIUYEhN31XRVA&usqp=CAU"),
    JeuModel("Megaman", "Etoile", "18",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRs6NMAvupGjYYMYT-FbR7OC8nwR6qhNbiZBA&usqp=CAU"),
  */
  ];
  //liste que l'on affiche
  List<JeuModel> affichage_listWish = List.from(list_wish);

  void updateList(String saisie) {
    //ajuste la List en fonction de la recherche
    setState(() {
      affichage_listWish = list_wish
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
          "Ma liste de souhaits",
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
              height: 20.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: affichage_listWish.length,
                itemBuilder: (context, index) => ListTile(
                  title: Column(
                    children: [
                      Text(affichage_listWish[index].jeu_titre!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.265845,
                            fontWeight: FontWeight.w400,
                            fontFamily: "ProximaNova-Regular",
                          )),
                      Text(affichage_listWish[index].jeu_editeur!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            fontFamily: "ProximaNova-Regular",
                          )),
                      Text(
                        "prix: "
                        '${affichage_listWish[index].jeu_prix!}'
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
                          MaterialPageRoute(builder: (context) => pageLike()),
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
                  leading:
                      Image.network(affichage_listWish[index].jeu_poster_url!),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
