import 'Question.dart';
import 'dart:math';

class QuizBrain {
  static var rng = new Random();
  static bool h = true, k = true;
  static Question currentQuestion;

  static List<Question> _quiz = new List<Question>();

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

  static void nextQuestion() {
    int _questionNumber = rng.nextInt(_quiz.length);
    currentQuestion = _quiz[_questionNumber];
  }

  static void setList(
      bool h, Map<String, bool> hv, bool k, Map<String, bool> kv) {
    QuizBrain.h = h;
    QuizBrain.k = k;

    if (h) {
      hv = Map.from(hv)..removeWhere((k, v) => v == false);

      hv.forEach(
        (k, v) => _hiragana[k].forEach(
          (k, v) => _quiz.add(Question(k, v)),
        ),
      );
    }

    if (k) {
      kv = Map.from(kv)..removeWhere((k, v) => v == false);

      kv.forEach(
        (k, v) => _katakana[k].forEach(
          (k, v) => _quiz.add(Question(k, v)),
        ),
      );
    }

    nextQuestion();
  }
}
