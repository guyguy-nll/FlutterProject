//source adapté: https://www.youtube.com/watch?v=jFHSkfjN96I
import 'package:flutter/material.dart';
import 'package:projet/jeuModele.dart';
import 'package:projet/whishlist.dart';
import 'dart:convert';
import 'package:projet/jeuModele.dart';
import 'package:projet/detailJeu.dart';
import 'package:http/http.dart' as http;
import 'package:projet/detailJeu.dart';

class pageRecherche extends StatefulWidget {
  const pageRecherche({Key? key}) : super(key: key);
  @override
  State<pageRecherche> createState() => _pageRecherche();
}

class _pageRecherche extends State<pageRecherche> {
  bool _enCoursDeRecherche = false;
  List<Map<String, dynamic>> _jeux = [];

  Future<void> _rechercherJeux(String recherche) async {
    setState(() {
      _enCoursDeRecherche = true;
    });

    final nomDuJeu = Uri.encodeComponent(recherche);
    final url = 'https://steamcommunity.com/actions/SearchApps/$nomDuJeu';
    final response = await http.get(Uri.parse(url));

    List<Map<String, dynamic>> jeux = [];
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final rawJeux = data as List<dynamic>;
      jeux = rawJeux
          .map((jeu) => {
                'appid': int.parse(jeu['appid'] as String),
                'name': jeu['name'] as String,
                'icon': jeu['img_logo_url'] != null
                    ? jeu['img_logo_url'] as String
                    : null,
              })
          .toList();
    }

    setState(() {
      _enCoursDeRecherche = false;
      _jeux = jeux;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1A2026),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        backgroundColor: Color(0xff1E262B),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (recherche) {
                _rechercherJeux(recherche);
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
                suffixIcon: Icon(
                  Icons.search,
                  color: Color(0xFF636AF6),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Nombre de résultats : ${_jeux.length}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontFamily: "ProximaNova-Regular",
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: _jeux.length,
                itemBuilder: (BuildContext context, int index) {
                  final nomJeu = _jeux[index]['name'] as String;
                  final idJeu = _jeux[index]['appid'].toString();
                  final iconUrl =
                      'https://cdn.cloudflare.steamstatic.com/steam/apps/${_jeux[index]['appid']}/header.jpg';

                  return Card(
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ColoredBox(
                            color: Color(0xFF232C34),
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10.0,
                            ),
                            Image.network(
                              iconUrl,
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
                                  Text(
                                    nomJeu,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.265845,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "ProximaNova-Regular",
                                    ),
                                  ),
                                  Text(
                                    idJeu,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "ProximaNova-Regular",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
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
                                  borderRadius: BorderRadius.circular(3.52),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          pageDetail(jeuId: int.parse(idJeu)),
                                    ),
                                  );
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "En savoir",
                                        style: TextStyle(
                                          color: Color(0xFFFFFFff),
                                          fontFamily: "ProximaNova-Regular",
                                          fontSize: 18.8,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text("plus",
                                          style: TextStyle(
                                              color: Color(0xFFFFFFff),
                                              fontFamily: "ProximaNova-Regular",
                                              fontSize: 18.8788733,
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
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


/*
class _pageRecherche extends State<pageRecherche> {
  bool _enCoursDeRecherche = false;
  List<Map<String, dynamic>> _jeux = [];

  Future<void> _rechercherJeux(String recherche) async {
    setState(() {
      _enCoursDeRecherche = true;
    });

    http.Response response =
        await http.get(Uri.parse('https://steamcommunity.com/actions/SearchApps/' + recherche));

    List<Map<String, dynamic>> jeux = [];
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      print(response.body);
      List<dynamic> data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        jeux = data
            .where((jeu) => jeu['type'] == 'game')
            .map<Map<String, dynamic>>((jeu) => {
                  'name': jeu['name'],
                  'id': jeu['appid'],
                  'icon': jeu['icon'],
                })
            .toList();
            print('le name est: ${jeux[0]['name']}');
      }
    }

    setState(() {
      _enCoursDeRecherche = false;
      _jeux = jeux;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (recherche) {
            _rechercherJeux(recherche);
          },
          decoration: InputDecoration(
            hintText: 'Rechercher un jeu...',
            suffixIcon: _enCoursDeRecherche ? CircularProgressIndicator() : null,
          ),
        ),
      ),
      body: Scrollbar(
        child: ListView.builder(
          itemCount: _jeux.length,
          itemBuilder: (BuildContext context, int index) {
            String nomJeu = _jeux[index]['name'];
            int idJeu = _jeux[index]['id'];
            String imageUrl = _jeux[index]['icon'];

            print('ID du jeu : $idJeu');
            print('URL de l\'icone : $imageUrl');
            print('Nom du jeu : $nomJeu');

            return Column(
              children: [
                ListTile(
                  leading: SizedBox(
                    width: 56,
                    height: 56,
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                  title: Text(nomJeu),
                  subtitle: Text('ID: $idJeu'),
                ),
                Container(
                  height: 102,
                  width: 100.99,
                  child: RawMaterialButton(
                    fillColor: Color(0xFF636af6),
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3.52),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => pageDetail(jeuId: idJeu),
                        ),
                      );
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "En savoir",
                            style: TextStyle(
                              color: Color(0xFFFFFFff),
                              fontFamily: "ProximaNova-Regular",
                              fontSize: 18.788733,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "plus",
                            style: TextStyle(
                              color: Color(0xFFFFFFff),
                              fontFamily: "ProximaNova-Regular",
                              fontSize: 18.788733,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
*/
 
/*
class _pageRecherche extends State<pageRecherche> {
  bool _enCoursDeRecherche = false;
  List<Map<String, dynamic>> _jeux = [];

  Future<void> _rechercherJeux(String recherche) async {
    setState(() {
      _enCoursDeRecherche = true;
    });

    http.Response response = await http.get(
        Uri.parse('https://steamcommunity.com/actions/SearchApps/' + recherche));

    List<Map<String, dynamic>> jeux = [];
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey('results')) {
        List<dynamic> rawJeux = data['results'];
        jeux = rawJeux
            .where((jeu) =>
                jeu['type'] == 'game')
            .toList()
            .cast<Map<String, dynamic>>();
      }
    }

    setState(() {
      _enCoursDeRecherche = false;
      _jeux = jeux;
    });
  }

  Future<String?> _getImageUrl(String id) async {
    final url =
        'https://store.steampowered.com/api/appdetails/?appids=$id&key=543CB15FFA49C7D4EAF4E917BBCC12B9&json=1';

    final response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      if (data.containsKey(id) &&
          data[id].containsKey('data') &&
          data[id]['data'].containsKey('header_image')) {
        return data[id]['data']['header_image'];
      }
    }
    return null;
  }

*/

/*
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: TextField(
        onChanged: (recherche) {
          _rechercherJeux(recherche);
        },
        decoration: InputDecoration(
          hintText: 'Rechercher un jeu...',
          suffixIcon: _enCoursDeRecherche ? CircularProgressIndicator() : null,
        ),
      ),
    ),
    body: Scrollbar(
      child: ListView.builder(
        itemCount: _jeux.length,
        itemBuilder: (BuildContext context, int index) {
          String nomJeu = _jeux[index]['name'];
          String idJeu = _jeux[index]['appid'].toString();
          return FutureBuilder<String?>(
            future: _getImageUrl(idJeu),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ListTile(
                  title: Text(nomJeu),
                  subtitle: Text('ID: $idJeu'),
                  leading: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return ListTile(
                  title: Text(nomJeu),
                  subtitle: Text('ID: $idJeu'),
                  leading: Icon(Icons.error),
                );
              }
              String? imageUrl = snapshot.data;
              return Column(
                children: [
                  ListTile(
                    leading: SizedBox(
                      width: 56,
                      height: 56,
                      child: imageUrl != null
                          ? Image.network(imageUrl, fit: BoxFit.cover)
                          : Placeholder(),
                    ),
                    title: Text(nomJeu),
                    subtitle: Text('ID: $idJeu'),
                  ),
                  Container(
                    height: 102,
                    width: 100.99,
                    child: RawMaterialButton(
                      fillColor: Color(0xFF636af6),
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.52),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => pageDetail(jeuId: int.parse(idJeu)),
                          ),
                        );
                      },
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "En savoir",
                              style: TextStyle(
                                color: Color(0xFFFFFFff),
                                fontFamily: "ProximaNova-Regular",
                                fontSize: 18.788733,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "plus",
                              style: TextStyle(
                                color: Color(0xFFFFFFff),
                                fontFamily: "ProximaNova-Regular",
                                fontSize: 18.788733,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    ),
  );
}

}
*/

 /*

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
                            affichage_list[index].jeu_poster_url!,
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
                                      children: [
                                        TextSpan(
                                          text:
                                              '${affichage_list[index].jeu_prix!}'
                                              "€",
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
                                          jeuId:
                                              affichage_list[index].jeu_id!)),
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
          ],
        ),
      ),
    );
  }
}
*/