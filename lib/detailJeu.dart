import 'package:flutter/material.dart';

class pageDetail extends StatefulWidget {
  const pageDetail({Key? key}) : super(key: key);
  @override
  State<pageDetail> createState() => _pageDetail();
}

class _pageDetail extends State<pageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text(
          "Détail du jeu",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: "GoogleSans-Bold",
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/fondDetailjeu.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  height: 40.23,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(3.52)),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: RawMaterialButton(
                            fillColor: Color(0xFF636af6),
                            elevation: 0.0,
                            onPressed: () {},
                            child: Text("DESCRIPTION",
                                style: TextStyle(
                                    color: Color(0xFFFFFFff),
                                    fontFamily: "GoogleSans-Bold",
                                    fontSize: 12.9172535,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: RawMaterialButton(
                            elevation: 0.0,
                            onPressed: () {},
                            child: Text("AVIS",
                                style: TextStyle(
                                    color: Color(0xFFFFFFff),
                                    fontFamily: "GoogleSans-Bold",
                                    fontSize: 12.9172535,
                                    fontWeight: FontWeight.w400)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 340,
                height: 110,
                color: Color.fromARGB(221, 34, 34, 34),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Image.asset("assets/images/jeu.jpg",
                        width: 79.85, height: 79.85),
                    Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Text("nom jeu",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.265845,
                              fontWeight: FontWeight.w400,
                              fontFamily: "ProximaNova-Regular",
                            )),
                        Text("auteur",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              fontFamily: "ProximaNova-Regular",
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
