import 'package:flutter/material.dart';
import 'package:kana/kana.dart';

class BasicGridView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //crossAxisCount: The number of children in the cross axis.
              crossAxisCount: 6,
              childAspectRatio: 1.0,
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
            ),
            //specify the list of children for the grid
            children: <Widget>[
              _emptyContainer(),
              _columnContainer("あ"),
              _columnContainer("い"),
              _columnContainer("う"),
              _columnContainer("え"),
              _columnContainer("お"),

              _columnContainer("お"),
              _buildContainer("a"),
              _buildContainer("i"),
              _buildContainer("u"),
              _buildContainer("e"),
              _buildContainer("o"),

              _columnContainer("か"),
              _buildContainer("ka"),
              _buildContainer("ki"),
              _buildContainer("ku"),
              _buildContainer("ke"),
              _buildContainer("ko"),

              _columnContainer("さ"),
              _buildContainer("sa"),
              _buildContainer("shi"),
              _buildContainer("su"),
              _buildContainer("se"),
              _buildContainer("so"),

              _columnContainer("た"),
              _buildContainer("ta"),
              _buildContainer("chi"),
              _buildContainer("tsu"),
              _buildContainer("te"),
              _buildContainer("to"),

              _columnContainer("な"),
              _buildContainer("na"),
              _buildContainer("ni"),
              _buildContainer("nu"),
              _buildContainer("ne"),
              _buildContainer("no"),

              _columnContainer("は"),
              _buildContainer("ha"),
              _buildContainer("hi"),
              _buildContainer("fu"),
              _buildContainer("he"),
              _buildContainer("ho"),

              _columnContainer("ま"),
              _buildContainer("ma"),
              _buildContainer("mi"),
              _buildContainer("mu"),
              _buildContainer("me"),
              _buildContainer("mo"),

              _columnContainer("や"),
              _buildContainer("ya"),
              _emptyContainer(),
              _buildContainer("yu"),
              _emptyContainer(),
              _buildContainer("yo"),

              _columnContainer("ら"),
              _buildContainer("ra"),
              _buildContainer("ri"),
              _buildContainer("ru"),
              _buildContainer("re"),
              _buildContainer("ro"),

              _columnContainer("わ"),
              _buildContainer("wa"),
              _emptyContainer(),
              _emptyContainer(),
              _emptyContainer(),
              _buildContainer("wo"),

              _emptyContainer(),
              _manualContainer("ん", "ン", "n")
            ],
            //specify direction in which it scrolls (horizontal or vertical).
            //scrollDirection: Axis.horizontal,
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(String hira) {
    return Container(
        height: 50.0,
        width: 60.0,
        color: Colors.grey.shade200,
        child: Center(
            child: Text.rich(
          TextSpan(
            text: getHiragana(hira),
            style: TextStyle(
              color: Colors.black,
              fontFamily: "AppleTPT",
              fontStyle: FontStyle.normal,
              fontSize: 20,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: '\n${getKatakana(hira)} ',
                  style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                      fontSize: 15)),
              TextSpan(
                  text: ' $hira',
                  style: TextStyle(
                      //fontStyle: FontStyle.italic,
                      color: Colors.grey.shade700,
                      fontSize: 15)),
            ],
          ),
          textAlign: TextAlign.center,
        )));
  }

  Widget _manualContainer(String hira, String kata, String roma) {
    return Container(
        height: 50.0,
        width: 60.0,
        color: Colors.grey.shade200,
        child: Center(
            child: Text.rich(
          TextSpan(
            text: hira,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: '\n$kata ',
                  style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                      fontSize: 15)),
              TextSpan(
                  text: ' $roma',
                  style: TextStyle(
                      //fontStyle: FontStyle.italic,
                      color: Colors.grey.shade700,
                      fontSize: 15)),
            ],
          ),
          textAlign: TextAlign.center,
        )));
  }

  Widget _columnContainer(String deep) {
    return Container(
        height: 50.0,
        width: 60.0,
        color: Colors.grey.shade200,
        child: Center(
            child: Text.rich(
          TextSpan(
            text: deep,
            style: TextStyle(
              color: Colors.deepOrangeAccent,
              fontSize: 20,
            ),
          ),
          textAlign: TextAlign.center,
        )));
  }

  Widget _emptyContainer() {
    return Container(
      height: 50.0,
      width: 60.0,
      color: Colors.grey.shade200,
    );
  }
}
