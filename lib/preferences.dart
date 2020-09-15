import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


Map<String, bool> _hirasol = {
  'あ い う え お': true,
  'か き く け こ': true,
  'さ し	す せ そ': true,
  'た ち つ て と': true,
  'な に ぬ ね の': true,
  'は ひ ふ へ ほ': true,
  'ま み む め も': true,
  'や ゆ よ': true,
  'ら り る れ ろ': true,
  'わ を': true,
  'ん': true
};

Map<String, bool> _katasol = {
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

  final String _hirasolSet =  "hiragana";
  final String _katasolSet = "katakana";

  /// ------------------------------------------------------------
  /// Method that returns the Hiragana set
  /// ------------------------------------------------------------
  Future<String> getHiraganaSet() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString(_hirasolSet) == null){
      print ("EMPTY HIRAGANA");
      return json.encode(_hirasol);
    }
    else{
      print ("EXISTS HIRAGANA");
      return prefs.getString(_hirasolSet);
    }
  }

  /// ----------------------------------------------------------
  /// Method that writes the Hiragana set
  /// ----------------------------------------------------------
  Future<bool> setHiraganaSet(Map<String, dynamic> value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(_hirasolSet, json.encode(value));
  }


/// ------------------------------------------------------------
/// Method that returns the Katakana set
/// ------------------------------------------------------------
Future<String> getKatakanaSet() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  if (prefs.getString(_katasolSet) == null){
    print ("EMPTY KATAKANA");
    return json.encode(_katasol);
  }
  else{
    print ("EXISTS KATAKANA");
    return prefs.getString(_katasolSet);
  }
}

/// ----------------------------------------------------------
/// Method that writes the Katakana set
/// ----------------------------------------------------------
Future<bool> setKatakanaSet(Map<String, dynamic> value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.setString(_katasolSet, json.encode(value));
}