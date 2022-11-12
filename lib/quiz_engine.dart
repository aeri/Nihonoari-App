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

import 'package:nihonoari/Models/Transliteration.dart';
import 'Question.dart';
import 'Models/KanaList.dart';
import 'Models/GlobalKanas.dart';
import 'dart:math';

class QuizBrain {
  static var rng = new Random();
  static bool h = true, k = true, re = true;
  static Question currentQuestion = Question("", [], "");

  static List<Question?> _quiz = [];
  static List<Question?> _passed = [];
  static List<Question?> _failed = [];

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
    currentQuestion = _quiz[_questionNumber] ?? Question("", [], "");
  }

  static void firstQuestion() {
    int _questionNumber = rng.nextInt(_quiz.length);
    currentQuestion = _quiz[_questionNumber] ?? Question("", [], "");
  }

  static void clearList() {
    _quiz.clear();
    _passed.clear();
    _failed.clear();
  }

  static void setList(bool h, Map<String, dynamic> hv, bool k,
      Map<String, dynamic> kv, bool isReverse, String locale) {
    QuizBrain.h = h;
    QuizBrain.k = k;
    QuizBrain.re = isReverse;

    List<String?> hiraganaAnswers = [];
    List<String?> hiraganaQuestions = [];
    List<String?> katakanaAnswers = [];
    List<String?> katakanaQuestions = [];

    if (h) {
      hv = Map.from(hv)..removeWhere((k, v) => v == false);
      hv.forEach(
        (k, v) {
          List<String>? hiraganaSetList = KanaList.hiragana[k];
          if (hiraganaSetList != null) {
            hiraganaSetList.forEach(
              (x) {
                hiraganaAnswers.clear();
                hiraganaQuestions.clear();

                switch (locale.split('_').first) {
                  case "uk":
                    {
                      hiraganaAnswers = (GlobalKanas.hiraganaMap[x]
                              ?.where((y) =>
                                  y.system == System.Kovalenko ||
                                  y.system == System.DibrovaOdinets ||
                                  y.system == System.Bondarenko ||
                                  y.system == System.Romaji)
                              .map((e) => e.value)
                              .toList()) ??
                          [];
                    }
                    break;
                  case "ru":
                    {
                      hiraganaAnswers = (GlobalKanas.hiraganaMap[x]
                              ?.where((y) =>
                                  y.system == System.Polivanov ||
                                  y.system == System.Romaji)
                              .map((e) => e.value)
                              .toList()) ??
                          [];
                    }
                    break;
                  default:
                    {
                      hiraganaAnswers = (GlobalKanas.hiraganaMap[x]
                              ?.where((y) => y.system == System.Romaji)
                              .map((e) => e.value)
                              .toList()) ??
                          [];
                    }
                    break;
                }

                if (re) {
                  // https://github.com/aeri/Nihonoari-App/issues/33
                  // enable distinguishing `ji`
                  if (x == "じ") {
                    hiraganaQuestions.add("ぢ");
                  }
                  if (x == "ぢ") {
                    hiraganaQuestions.add("じ");
                  }
                  // enable distinguishing `zu`
                  if (x == "ず") {
                    hiraganaQuestions.add("づ");
                  }
                  if (x == "づ") {
                    hiraganaQuestions.add("ず");
                  }
                  hiraganaQuestions.add(x);
                  _quiz.add(Question(hiraganaAnswers.last ?? "",
                      hiraganaQuestions, "hiragana"));
                } else {
                  _quiz.add(Question(x, hiraganaAnswers, "hiragana"));
                }
              },
            );
          } else {
            print("Bad hiragana configuration:  " + k);
          }
        },
      );
    }

    if (k) {
      kv = Map.from(kv)..removeWhere((k, v) => v == false);

      kv.forEach((k, v) {
        List<String>? katakanaSetList = KanaList.katakana[k];
        if (katakanaSetList != null) {
          katakanaSetList.forEach(
            (x) {
              katakanaAnswers.clear();
              katakanaQuestions.clear();

              switch (locale.split('_').first) {
                case "uk":
                  {
                    katakanaAnswers = (GlobalKanas.katakanaMap[x]
                            ?.where((y) =>
                                y.system == System.Kovalenko ||
                                y.system == System.DibrovaOdinets ||
                                y.system == System.Bondarenko ||
                                y.system == System.Romaji)
                            .map((e) => e.value)
                            .toList()) ??
                        [];
                  }
                  break;
                case "ru":
                  {
                    katakanaAnswers = (GlobalKanas.katakanaMap[x]
                            ?.where((y) =>
                                y.system == System.Polivanov ||
                                y.system == System.Romaji)
                            .map((e) => e.value)
                            .toList()) ??
                        [];
                  }
                  break;
                default:
                  {
                    katakanaAnswers = (GlobalKanas.katakanaMap[x]
                            ?.where((y) => y.system == System.Romaji)
                            .map((e) => e.value)
                            .toList()) ??
                        [];
                  }
                  break;
              }

              if (re) {
                // https://github.com/aeri/Nihonoari-App/issues/33
                // enable distinguishing `ji`
                if (x == "ジ") {
                  katakanaQuestions.add("ヂ");
                }
                if (x == "ヂ") {
                  katakanaQuestions.add("ジ");
                }
                // enable distinguishing `zu`
                if (x == "ズ") {
                  katakanaQuestions.add("ヅ");
                }
                if (x == "ヅ") {
                  katakanaQuestions.add("ズ");
                }
                katakanaQuestions.add(x);
                _quiz.add(Question(
                    katakanaAnswers.last ?? "", katakanaQuestions, "katakana"));
              } else {
                _quiz.add(Question(x, katakanaAnswers, "katakana"));
              }
            },
          );
        } else {
          print("Bad katakana configuration:  " + k);
        }
      });
    }
    firstQuestion();
  }
}
