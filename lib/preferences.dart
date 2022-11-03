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
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedKanaPreferences {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences?> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance;
  }

  static Map<String, bool> _defaultHiraganaSet = {
    'あ い う え お': true,
    'か き く け こ': true,
    'さ し す せ そ': true,
    'た ち つ て と': true,
    'な に ぬ ね の': true,
    'は ひ ふ へ ほ': true,
    'ま み む め も': true,
    'や ゆ よ': true,
    'ら り る れ ろ': true,
    'わ を': true,
    'ん': true
  };

  static Map<String, bool> _defaultKatakanaSet = {
    'ア イ ウ エ オ': true,
    'カ キ ク ケ コ': true,
    'サ シ ス セ ソ': true,
    'タ チ ツ テ ト': true,
    'ナ ニ ヌ ネ ノ': true,
    'ハ ヒ フ ヘ ホ': true,
    'マ ミ ム メ モ': true,
    'ヤ ユ ヨ': true,
    'ラ リ ル レ ロ': true,
    'ワ ヲ': true,
    'ン': true,
  };

  static final String _hirasolSet = "hiragana";
  static final String _katasolSet = "katakana";

  static String getHiraganaSet() {
    var hiraganaData = _prefsInstance!.getString(_hirasolSet);

    if (hiraganaData == null) {
      print("EMPTY HIRAGANA");
      return json.encode(_defaultHiraganaSet);
    } else {
      print("EXISTS HIRAGANA");
      return hiraganaData.replaceAll("\\t", " ");
    }
  }

  static Future<bool> setHiraganaSet(Map<String, dynamic>? value) async {
    return _prefsInstance!.setString(_hirasolSet, json.encode(value));
  }

  static String getKatakanaSet() {
    var katakanaData = _prefsInstance!.getString(_katasolSet);

    if (katakanaData == null) {
      print("EMPTY KATAKANA");
      return json.encode(_defaultKatakanaSet);
    } else {
      print("EXISTS KATAKANA");
      return katakanaData.replaceAll("\\t", " ");
    }
  }

  static Future<bool> setKatakanaSet(Map<String, dynamic>? value) async {
    return _prefsInstance!.setString(_katasolSet, json.encode(value));
  }
}
