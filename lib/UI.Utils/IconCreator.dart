import 'package:flutter/material.dart';

class IconCreator extends StatelessWidget {

  IconCreator(this.icon);

  final String icon;

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        color: Colors.white,
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
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}