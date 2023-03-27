import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PageLikevide extends StatefulWidget {
  const PageLikevide({super.key});

  @override
  State<PageLikevide> createState() => _PageLikevide();
}

class _PageLikevide extends State<PageLikevide> {
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
          "Mes likes",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            fontFamily: "GoogleSans-Bold",
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(
              'assets/images/empty_likes.svg',
              width: 94.0,
              height: 94.0,
              color: Colors.white,
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              "Vous n'avez pas liké de contenu.\n cliquez sur le coeur pour en ajouter",
              style: TextStyle(
                color: Color(0xFFFFFFff),
                fontFamily: "ProximaNova-Regular",
                fontSize: 15.265845,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
