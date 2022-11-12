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

import 'dart:async';
import 'dart:io';

import 'package:nihonoari/preferences.dart';
import 'package:flutter/material.dart';
import 'localizations.dart';
import 'quiz_engine.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'table.dart';

class Party extends StatefulWidget {
  final bool h, k, re;

  final Map<String, dynamic> hv, kv;

  Party(
      {required this.h,
      required this.hv,
      required this.k,
      required this.kv,
      required this.re});

  @override
  _Party createState() => _Party(h, hv, k, kv, re);
}

class _Party extends State<Party> {
  _Party(h, hv, k, kv, re) {
    SharedKanaPreferences.setHiraganaSet(hv);
    SharedKanaPreferences.setKatakanaSet(kv);

    //var loc = WidgetsBinding.instance.window.locales;
    var currentDefaultSystemLocale = Platform.localeName;
    QuizBrain.setList(h, hv, k, kv, re, currentDefaultSystemLocale);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void showInSnackBar(int control, String result) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 10,
      duration: Duration(milliseconds: control),
      content: Text(
        '${AppLocalizations.of(context)!.translate('quiz_correct')}: $result',
        style: TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ));
  }

  void hideSnackbar() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
  }

  FocusNode _focusNode = FocusNode();

  bool _ignore = false;

  Timer? t;

  Color _result = Colors.white;

  TextEditingController _controller = TextEditingController();

  List<Widget> scoreKeeper = [];
  int total = 0;
  int accepted = 0;
  int rejected = 0;
  double ratio = 0;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FocusScope.of(context).requestFocus(_focusNode);
      }
    });
  }

  void _showDialog() async {
    hideSnackbar();
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.black,
          title:
              new Text(AppLocalizations.of(context)!.translate('quiz_stats')!,
                  style: TextStyle(
                    color: Colors.white,
                  )),
          content: new Text(
              "${AppLocalizations.of(context)!.translate('quiz_total')}: $total\n"
              "${AppLocalizations.of(context)!.translate('quiz_passed')}: $accepted\n"
              "${AppLocalizations.of(context)!.translate('quiz_failed')}: $rejected\n"
              "${AppLocalizations.of(context)!.translate('quiz_rate')}: ${ratio.toStringAsFixed(2)}%",
              style: TextStyle(
                color: Colors.white,
              )),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new TextButton(
              child: new Icon(
                Icons.done,
                color: Colors.red,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<bool> _onBackPressed() {
    FocusScope.of(context).requestFocus(new FocusNode());
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        backgroundColor: Colors.black,
        title:
            new Text(AppLocalizations.of(context)!.translate('quiz_stoptit')!,
                style: TextStyle(
                  color: Colors.white,
                )),
        content:
            new Text(AppLocalizations.of(context)!.translate('quiz_stopmes')!,
                style: TextStyle(
                  color: Colors.white,
                )),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new TextButton(
            child: new Icon(
              Icons.close,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          new TextButton(
            child: new Icon(
              Icons.done,
              color: Colors.red,
            ),
            onPressed: () {
              if (t != null && t!.isActive) t!.cancel();
              QuizBrain.clearList();
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    ).then((value) => true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                    flex: 0,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: IconButton(
                                // Use the FontAwesomeIcons class for the IconData
                                icon: new Icon(FontAwesomeIcons.language,
                                    color: Colors.white),
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BasicGridView()),
                                  );
                                })),
                        Expanded(
                            child: IconButton(
                                // Use the FontAwesomeIcons class for the IconData
                                icon: new Icon(FontAwesomeIcons.chartBar,
                                    color: Colors.white),
                                onPressed: () {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  _showDialog();
                                })),
                      ],
                    )),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          QuizBrain.currentQuestion.question,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'MP1P_LIGHT',
                            fontSize: 125.0,
                            color: _result,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: TextField(
                  textInputAction: TextInputAction.done,
                  controller: _controller,
                  focusNode: _focusNode,
                  autofocus: true,
                  textAlign: TextAlign.center,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      hoverColor: Colors.white,
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: (() {
                        if (QuizBrain.re) {
                          if (QuizBrain.currentQuestion.type == "hiragana") {
                            return AppLocalizations.of(context)!
                                .translate('quiz_enter_hira');
                          } else {
                            return AppLocalizations.of(context)!
                                .translate('quiz_enter_kata');
                          }
                        } else {
                          return AppLocalizations.of(context)!
                              .translate('quiz_enter');
                        }
                      })()),
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  onSubmitted: (value) {
                    if (_ignore || value.length < 1) {
                      return;
                    }
                    _ignore = true;

                    int control = 0;
                    bool passed = false;

                    _controller.clear();

                    List<String?> answer = QuizBrain.currentQuestion.answer;

                    ++total;

                    setState(() {
                      // check if an extra answer is available, and if so, if it matches.
                      // this is part of the fix for #33
                      if (answer.contains(value.toLowerCase())) {
                        control = 500;
                        print("OK");
                        _result = Colors.green;
                        ++accepted;
                        passed = true;
                      } else {
                        control = 2000;
                        print("NO");
                        _result = Colors.red;
                        ++rejected;
                        showInSnackBar(
                            control, answer.toSet().toList().join(" / "));
                      }
                    });

                    ratio = (accepted / total) * 100;

                    t = Timer(Duration(milliseconds: control), () {
                      setState(() {
                        _result = Colors.white;
                        QuizBrain.nextQuestion(passed);
                        _ignore = false;
                      });
                    });

                    // and later, before the timer goes off...
                  },
                )),
                Expanded(
                  child: Row(
                    children: scoreKeeper,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
