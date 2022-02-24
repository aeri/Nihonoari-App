/*
    Copyright (C) 2020 Naval Alcalá

    This file is part of Nihonoari.

    Nihonoari is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Nihonoari is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Nihonoari.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';
import 'package:kana_kit/kana_kit.dart';

const kanaKit = KanaKit();

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
              _columnContainer("a"),
              _columnContainer("i"),
              _columnContainer("u"),
              _columnContainer("e"),
              _columnContainer("o"),

              _columnContainer("a"),
              _buildContainer("a"),
              _buildContainer("i"),
              _buildContainer("u"),
              _buildContainer("e"),
              _buildContainer("o"),

              _columnContainer("k"),
              _buildContainer("ka"),
              _buildContainer("ki"),
              _buildContainer("ku"),
              _buildContainer("ke"),
              _buildContainer("ko"),

              _columnContainer("s"),
              _buildContainer("sa"),
              _buildContainer("shi"),
              _buildContainer("su"),
              _buildContainer("se"),
              _buildContainer("so"),

              _columnContainer("t"),
              _buildContainer("ta"),
              _buildContainer("chi"),
              _buildContainer("tsu"),
              _buildContainer("te"),
              _buildContainer("to"),

              _columnContainer("n"),
              _buildContainer("na"),
              _buildContainer("ni"),
              _buildContainer("nu"),
              _buildContainer("ne"),
              _buildContainer("no"),

              _columnContainer("h"),
              _buildContainer("ha"),
              _buildContainer("hi"),
              _buildContainer("fu"),
              _buildContainer("he"),
              _buildContainer("ho"),

              _columnContainer("m"),
              _buildContainer("ma"),
              _buildContainer("mi"),
              _buildContainer("mu"),
              _buildContainer("me"),
              _buildContainer("mo"),

              _columnContainer("y"),
              _buildContainer("ya"),
              _emptyContainer(),
              _buildContainer("yu"),
              _emptyContainer(),
              _buildContainer("yo"),

              _columnContainer("r"),
              _buildContainer("ra"),
              _buildContainer("ri"),
              _buildContainer("ru"),
              _buildContainer("re"),
              _buildContainer("ro"),

              _columnContainer("w"),
              _buildContainer("wa"),
              _emptyContainer(),
              _emptyContainer(),
              _emptyContainer(),
              _buildContainer("wo"),

              _emptyContainer(),
              _buildContainer("n"),
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
            text: kanaKit.toHiragana(hira),
            style: TextStyle(
              color: Colors.black,
              fontFamily: "MP1P_MEDIUM",
              fontStyle: FontStyle.normal,
              fontSize: 16,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: '\n${kanaKit.toKatakana(hira)} ',
                  style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                      fontSize: 15)),
              TextSpan(
                  text: ' $hira',
                  style: TextStyle(
                      //fontStyle: FontStyle.italic,
                      color: Colors.grey.shade700,
                      fontSize: 13)),
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
              fontFamily: "MP1P_MEDIUM",
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
