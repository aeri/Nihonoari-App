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

import 'Question.dart';
import 'dart:math';

class QuizBrain {
  static var rng = new Random();
  static bool h = true, k = true, re = true;
  static Question currentQuestion;

  static List<Question> _quiz = new List<Question>();
  static List<Question> _passed = new List<Question>();
  static List<Question> _failed = new List<Question>();

  static var _hiragana = {
    "あ い う え お": {
      "あ": "a",
      "い": "i",
      "う": "u",
      "え": "e",
      "お": "o",
    },
    "か き く け こ": {
      "か": "ka",
      "き": "ki",
      "く": "ku",
      "け": "ke",
      "こ": "ko",
      "が": "ga",
      "ぎ": "gi",
      "ぐ": "gu",
      "げ": "ge",
      "ご": "go",
    },
    "さ し	す せ そ": {
      "さ": "sa",
      "し": "shi",
      "す": "su",
      "せ": "se",
      "そ": "so",
      "ざ": "za",
      "じ": "ji",
      "ず": "zu",
      "ぜ": "ze",
      "ぞ": "zo",
    },
    "た ち つ て と": {
      "た": "ta",
      "ち": "chi",
      "つ": "tsu",
      "て": "te",
      "と": "to",
      "だ": "da",
      "ぢ": "ji",
      "づ": "zu",
      "で": "de",
      "ど": "do",
    },
    "な に ぬ ね の": {
      "な": "na",
      "に": "ni",
      "ぬ": "nu",
      "ね": "ne",
      "の": "no",
    },
    "は ひ ふ へ ほ": {
      "は": "ha",
      "ひ": "hi",
      "ふ": "fu",
      "へ": "he",
      "ほ": "ho",
      "ば": "ba",
      "び": "bi",
      "ぶ": "bu",
      "べ": "be",
      "ぼ": "bo",
      "ぱ": "pa",
      "ぴ": "pi",
      "ぷ": "pu",
      "ぺ": "pe",
      "ぽ": "po",
    },
    "ま み む め も": {
      "ま": "ma",
      "み": "mi",
      "む": "mu",
      "め": "me",
      "も": "mo",
    },
    "や ゆ よ": {
      "や": "ya",
      "ゆ": "yu",
      "よ": "yo",
    },
    "ら り る れ ろ": {
      "ら": "ra",
      "り": "ri",
      "る": "ru",
      "れ": "re",
      "ろ": "ro",
    },
    "わ を": {
      "わ": "wa",
      "を": "wo",
    },
    "ん": {"ん": "n"}
  };

  static var _katakana = {
    "ア イ ウ エ オ": {
      "ア": "a",
      "イ": "i",
      "ウ": "u",
      "エ": "e",
      "オ": "o",
    },
    "カ キ ク ケ コ": {
      "カ": "ka",
      "キ": "ki",
      "ク": "ku",
      "ケ": "ke",
      "コ": "ko",
      "ガ": "ga",
      "ギ": "gi",
      "グ": "gu",
      "ゲ": "ge",
      "ゴ": "go",
    },
    "サ シ ス セ ソ": {
      "サ": "sa",
      "シ": "shi",
      "ス": "su",
      "セ": "se",
      "ソ": "so",
      "ザ": "za",
      "ジ": "ji",
      "ズ": "zu",
      "ゼ": "ze",
      "ゾ": "zo",
    },
    "タ チ ツ テ ト": {
      "タ": "ta",
      "チ": "chi",
      "ツ": "tsu",
      "テ": "te",
      "ト": "to",
      "ダ": "da",
      "ヂ": "ji",
      "ヅ": "zu",
      "デ": "de",
      "ド": "do",
    },
    "ナ ニ ヌ ネ ノ": {
      "ナ": "na",
      "ニ": "ni",
      "ヌ": "nu",
      "ネ": "ne",
      "ノ": "no",
    },
    "ハ ヒ フ ヘ ホ": {
      "ハ": "ha",
      "ヒ": "hi",
      "フ": "fu",
      "ヘ": "he",
      "ホ": "ho",
      "バ": "ba",
      "ビ": "bi",
      "ブ": "bu",
      "ベ": "be",
      "ボ": "bo",
      "パ": "pa",
      "ピ": "pi",
      "プ": "pu",
      "ペ": "pe",
      "ポ": "po",
    },
    "マ ミ ム メ モ": {
      "マ": "ma",
      "ミ": "mi",
      "ム": "mu",
      "メ": "me",
      "モ": "mo",
    },
    "ヤ ユ ヨ": {
      "ヤ": "ya",
      "ユ": "yu",
      "ヨ": "yo",
    },
    "ラ リ ル レ ロ": {
      "ラ": "ra",
      "リ": "ri",
      "ル": "ru",
      "レ": "re",
      "ロ": "ro",
    },
    "ワ ヲ": {
      "ワ": "wa",
      "ヲ": "wo",
    },
    "ン": {
      "ン": "n",
    }
  };

  static void nextQuestion(bool passed) {
    if (passed) {
      _passed.add(currentQuestion);
      _quiz.remove(currentQuestion);
    } else {
      _failed.add(currentQuestion);
      _quiz.remove(currentQuestion);
    }

    if (_quiz.length == 0) {
      if (_failed.length == 0) {
        _quiz.addAll(_passed);
        _passed.clear();
      } else {
        _quiz.addAll(_failed);
        _failed.clear();
      }
    }
    int _questionNumber = rng.nextInt(_quiz.length);
    currentQuestion = _quiz[_questionNumber];
  }

  static void firstQuestion() {
    int _questionNumber = rng.nextInt(_quiz.length);
    currentQuestion = _quiz[_questionNumber];
  }

  static void clearList(){
    _quiz.clear();
    _passed.clear();
    _failed.clear();
  }

  static void setList(
      bool h, Map<String, dynamic> hv, bool k, Map<String, dynamic> kv, bool re) {
    QuizBrain.h = h;
    QuizBrain.k = k;
    QuizBrain.re = re;

    if (h) {
      hv = Map.from(hv)..removeWhere((k, v) => v == false);

      hv.forEach(
        (k, v) => _hiragana[k].forEach(
          (k, v) {
            if (re) {
              // https://github.com/aeri/Nihonoari-App/issues/33
              // enable distinguishing `ji`
              String extra = null;
              if ( k == "じ") {
                extra = "ぢ";
              }
              if (k == "ぢ") {
                extra = "じ";
              }
              // enable distinguishing `zu`
              if (k == "ず") {
                extra = "づ";
              }
              if ( k == "づ") {
                extra = "ず";
              }
              _quiz.add(Question(v, k, "hiragana", extra));
            } else {
              _quiz.add(Question(k, v, "hiragana"));
            }
          },
        ),
      );
    }

    if (k) {
      kv = Map.from(kv)..removeWhere((k, v) => v == false);

      kv.forEach(
        (k, v) => _katakana[k].forEach(
              (k, v) {
            if (re) {
              // https://github.com/aeri/Nihonoari-App/issues/33
              // enable distinguishing `ji`
              String extra = null;
              if ( k == "ジ") {
                extra = "ヂ";
              }
              if (k == "ヂ") {
                extra = "ジ";
              }
              // enable distinguishing `zu`
              if (k == "ズ") {
                extra = "ヅ";
              }
              if ( k == "ヅ") {
                extra = "ズ";
              }
              _quiz.add(Question(v, k, "katakana", extra));
            } else {
              _quiz.add(Question(k, v, "katakana"));
            }
          },
        ),
      );
    }

    firstQuestion();
  }
}
