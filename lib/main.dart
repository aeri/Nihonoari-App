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

import 'dart:convert';

import 'package:nihonoari/Models/Transliteration.dart';

import 'UI.Utils/IconCreator.dart';
import 'Models/GlobalKanas.dart';
import 'preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'party.dart';
import 'package:flutter/gestures.dart';

import 'localizations.dart';

import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> loadAsset(String asset) async {
  return await rootBundle.loadString(asset);
}

Map<String, dynamic> _hirasol = new Map<String, bool?>();
Map<String, dynamic> _katasol = new Map<String, bool?>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String hiraRawData = await loadAsset("assets/data/hira.json");
  String kanaRawData = await loadAsset("assets/data/kata.json");
  GlobalKanas.hiraganaMap = kanasFromJson(hiraRawData);
  GlobalKanas.katakanaMap = kanasFromJson(kanaRawData);

  runApp(new MaterialApp(
    supportedLocales: [
      Locale('en', 'US'),
      Locale('es', ''),
      Locale('fr', ''),
      Locale('uk', ''),
      Locale('ru', ''),
      Locale('be', ''),
      Locale('tr', ''),
      Locale('de', '')
    ],
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      DefaultWidgetsLocalizations.delegate,
    ],
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => new _State();
}

class HiraDialog extends StatefulWidget {
  @override
  _HiraDialogState createState() => _HiraDialogState();
}

class KataDialog extends StatefulWidget {
  @override
  _KataDialogState createState() => _KataDialogState();
}

class _HiraDialogState extends State<HiraDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.translate('main_hset')!,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black,
      content: Container(
        width: double.maxFinite,
        child: new Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: new ListView(
            children: _hirasol.keys.map((String key) {
              return new CheckboxListTile(
                title: new Text(
                  key,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                activeColor: Colors.red,
                value: _hirasol[key],
                onChanged: (bool? value) {
                  setState(() {
                    _hirasol[key] = value;
                  });
                },
              );
            }).toList(),
          ),
        ),
      ),
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
  }
}

class _KataDialogState extends State<KataDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black,
      title: Text(
        AppLocalizations.of(context)!.translate('main_kset')!,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      content: Container(
        width: double.maxFinite,
        child: Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: new ListView(
            children: _katasol.keys.map((String key) {
              return new CheckboxListTile(
                title: new Text(
                  key,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                value: _katasol[key],
                activeColor: Colors.red,
                onChanged: (bool? value) {
                  setState(() {
                    _katasol[key] = value;
                  });
                },
              );
            }).toList(),
          ),
        ),
      ),
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
  }
}

//State is information of the application that can change over time or when some actions are taken.
class _State extends State<MyApp> {
  bool _katakana = false;
  bool _hiragana = false;
  bool _reverse = false;

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<Null> readData() async {
    await SharedKanaPreferences.init();
    _hirasol = json.decode(SharedKanaPreferences.getHiraganaSet());
    _katasol = json.decode(SharedKanaPreferences.getKatakanaSet());
  }

  bool _isButtonDisabled = true;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _katakanaChanged(bool value) => setState(() => _katakana = value);

  void _hiraganaChanged(bool value) => setState(() => _hiragana = value);

  void __isButtonDisabledChanged() {
    _isButtonDisabled = _katakana || _hiragana ? false : true;
  }

  void _showLicense() async {
    String data = await loadAsset("assets/LICENSES.txt");
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Licenses"),
          content: new SingleChildScrollView(
            child: Text(data),
          ),
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.grey.shade900,
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(25.0),
                        child: RichText(
                          text: TextSpan(
                            text: 'nihonoari ',
                            style: TextStyle(
                              fontFamily: 'MP1P_LIGHT',
                              fontSize: 25.0,
                              color: Colors.white,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: 'project',
                                  style: TextStyle(fontFamily: 'MP1P_REGULAR')),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: RichText(
                          text: TextSpan(
                            text: AppLocalizations.of(context)!
                                .translate('main_licenses'),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                _showLicense();
                              },
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 1,
                child: Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: new Column(children: <Widget>[
                    new CheckboxListTile(
                      value: _hiragana,
                      onChanged: (value) async {
                        if (value!) {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return HiraDialog();
                            },
                          );
                        }
                        if (!_hirasol.containsValue(true)) {
                          _hiraganaChanged(false);
                        } else {
                          _hiraganaChanged(value);
                        }
                        __isButtonDisabledChanged();
                      },
                      title: new Text(
                        'Hiragana',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      subtitle: new Text(
                        AppLocalizations.of(context)!
                            .translate('main_hiragana')!,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      secondary: new IconCreator("あ"),
                      activeColor: Colors.red,
                    ),
                    new CheckboxListTile(
                      value: _katakana,
                      onChanged: (value) async {
                        if (value!) {
                          await showDialog(
                            context: context,
                            builder: (context) {
                              return KataDialog();
                            },
                          );
                        }

                        if (!_katasol.containsValue(true)) {
                          _katakanaChanged(false);
                        } else {
                          _katakanaChanged(value);
                        }
                        __isButtonDisabledChanged();
                      },
                      title: new Text(
                        'Katakana',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      subtitle: new Text(
                        AppLocalizations.of(context)!
                            .translate('main_katakana')!,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      secondary: new IconCreator("ア"),
                      activeColor: Colors.red,
                    ),
                    SwitchListTile(
                      title: new Text(
                        AppLocalizations.of(context)!.translate('main_rset')!,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      subtitle: new Text(
                        AppLocalizations.of(context)!
                            .translate('main_reverse')!,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _reverse,
                      activeColor: Colors.red,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.black,
                      onChanged: (bool value) {
                        setState(() {
                          _reverse = value;
                        });
                      },
                      secondary: new IconCreator("A"),
                    )
                  ]),
                ),
              ),
              Expanded(
                flex: 0,
                child: Center(
                  child: new ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(100, 50),
                        textStyle: TextStyle(
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        primary: Colors.red,
                        // background
                        onPrimary: Colors.white,
                        // foreground
                        onSurface: Colors.white),
                    onPressed: _isButtonDisabled
                        ? null
                        : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => new Party(
                                      h: _hiragana,
                                      hv: _hirasol,
                                      k: _katakana,
                                      kv: _katasol,
                                      re: _reverse)),
                            );
                          },
                    child: new Text(_isButtonDisabled
                        ? AppLocalizations.of(context)!
                            .translate('main_select')!
                        : AppLocalizations.of(context)!
                            .translate('main_start')!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
