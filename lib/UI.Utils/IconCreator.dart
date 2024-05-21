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

class IconCreator extends StatelessWidget {
  IconCreator(this.icon);

  final String icon;

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: new BorderRadius.circular(4.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
      //padding: new EdgeInsets.all(4.0),
      height: 25.0,
      width: 25.0,
      child: Align(
        alignment: Alignment.center,
        child: new Text(
          icon,
          style: new TextStyle(
            fontSize: 16.0,
            fontFamily: "MP1P_MEDIUM",
            fontStyle: FontStyle.normal,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}
