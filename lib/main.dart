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
    darkTheme: ThemeData(
        useMaterial3: true,
        // Define the default brightness and colors.
        colorScheme: ColorScheme(
          primary: Colors.red,
          secondary: Colors.white,
          error: Colors.red,
          onBackground: Colors.white,
          onError: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.white,
          surface: Colors.black,
          tertiary: Colors.grey,
          background: Colors.black,
          brightness: Brightness.dark,

        ),
      dialogTheme: const DialogTheme(
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.grey,
      ),

        unselectedWidgetColor: Colors.white,
        textTheme: TextTheme(
          displayLarge: const TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.bold,
          ),

        ),
    ),
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        primary: Colors.redAccent,
        secondary: Color(0xff011627),
        error: Colors.redAccent,
        onBackground: Color(0xff011627),
        onError: Colors.redAccent,
        onPrimary: Color(0xfffffbff),
        onSecondary: Color(0xfffffbff),
        onSurface: Color(0xff011627),
        surface: Color(0xfffffbff),
        tertiary: Colors.grey,
        background: Color(0xfffffbff),
        brightness: Brightness.light,
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: Color(0xfffffbff),
        surfaceTintColor: Colors.transparent,
      ),
      /* dark theme settings */
    ),
    themeMode: ThemeMode.system,
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
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      content: Container(
        width: double.maxFinite,
        child: new ListView(
            children: _hirasol.keys.map((String key) {
              return new CheckboxListTile(
                title: new Text(
                  key,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                checkColor: Theme.of(context).colorScheme.onPrimary,
                activeColor: Theme.of(context).colorScheme.primary,
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
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new TextButton(
          child: new Icon(
            Icons.done,
            color: Theme.of(context).colorScheme.primary,
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
      title: Text(
        AppLocalizations.of(context)!.translate('main_kset')!,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      content: Container(
        width: double.maxFinite,
        child: new ListView(
            children: _katasol.keys.map((String key) {
              return new CheckboxListTile(
                title: new Text(
                  key,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                checkColor: Theme.of(context).colorScheme.onPrimary,
                activeColor: Theme.of(context).colorScheme.primary,
                value: _katasol[key],
                onChanged: (bool? value) {
                  setState(() {
                    _katasol[key] = value;
                  });
                },
              );
            }).toList(),
          ),
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new TextButton(
          child: new Icon(
            Icons.done,
            color: Theme.of(context).colorScheme.primary,
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
    await AppPreferences.init();
    _hirasol = json.decode(AppPreferences.getHiraganaSet());
    _katasol = json.decode(AppPreferences.getKatakanaSet());
  }

  bool _isButtonDisabled = true;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _katakanaChanged(bool value) => setState(() => _katakana = value);

  void _hiraganaChanged(bool value) => setState(() => _hiragana = value);

  void __isButtonDisabledChanged() {
    _isButtonDisabled = _katakana || _hiragana ? false : true;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
                                color: Theme.of(context).colorScheme.secondary,

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
                                showLicensePage(
                                  context: context,
                                  applicationName: 'Nihonoari',
                                  applicationLegalese: 'Copyright (C) 2020  Naval Alcalá',
                                );
                              },
                            style: TextStyle(
                              fontSize: 15.0,
                                color: Theme.of(context).colorScheme.tertiary,

                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                flex: 1,
                child: new Column(children: <Widget>[
                    new CheckboxListTile(
                      checkColor: Theme.of(context).colorScheme.onPrimary,
                      activeColor: Theme.of(context).colorScheme.primary,
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
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      subtitle: new Text(
                        AppLocalizations.of(context)!
                            .translate('main_hiragana')!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      secondary: new IconCreator("あ"),
                    ),
                    new CheckboxListTile(
                      value: _katakana,
                      checkColor: Theme.of(context).colorScheme.onPrimary,
                      activeColor: Theme.of(context).colorScheme.primary,
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
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      subtitle: new Text(
                        AppLocalizations.of(context)!
                            .translate('main_katakana')!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      secondary: new IconCreator("ア"),
                    ),
                    SwitchListTile(
                      title: new Text(
                        AppLocalizations.of(context)!.translate('main_rset')!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      subtitle: new Text(
                        AppLocalizations.of(context)!
                            .translate('main_reverse')!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: _reverse,
                      activeColor: Theme.of(context).colorScheme.onPrimary,
                      activeTrackColor: Theme.of(context).colorScheme.primary,
                      inactiveThumbColor: Theme.of(context).colorScheme.secondary,
                      inactiveTrackColor: Theme.of(context).colorScheme.background,
                      onChanged: (bool value) {
                        setState(() {
                          _reverse = value;
                        });
                      },
                      secondary: new IconCreator("A"),
                    )
                  ]),
              ),
              Expanded(
                flex: 0,
                child: Center(
                  child: new ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(100, 50),
                        padding: const EdgeInsets.all(8.0),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.secondary,
                    ),
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
                            .translate('main_start')!,style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary
                    ),),
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
