import 'Question.dart';
import 'dart:math';
import 'package:kana/kana.dart';

class QuizBrain{

  static var rng = new Random();

  static List<Question> _questionBank = [
    Question ("あ", "a"),
    Question ("い", "i"),
    Question ("う", "u"),
    Question ("え", "e"),
    Question ("お", "o"),
    Question ("や", "ya"),
    Question ("ゆ", "yu"),
    Question ("よ", "yo"),
    Question ("わ", "wa"),
    Question ("か", "ka"),
    Question ("き", "ki"),
    Question ("く", "ku"),
    Question ("け", "ke"),
    Question ("こ", "ko"),
    Question ("さ", "sa"),
    Question ("し", "shi"),
    Question ("す", "su"),
    Question ("せ", "se"),
    Question ("そ", "so"),
    Question ("た", "ta"),
    Question ("ち", "chi"),
    Question ("つ", "tsu"),
    Question ("て", "te"),
    Question ("と", "to"),
    Question ("な", "na"),
    Question ("に", "ni"),
    Question ("ぬ", "nu"),
    Question ("ね", "ne"),
    Question ("の", "no"),
    Question ("は", "ha"),
    Question ("ひ", "hi"),
    Question ("ふ", "fu"),
    Question ("へ", "he"),
    Question ("ほ", "ho"),
    Question ("ま", "ma"),
    Question ("み", "mi"),
    Question ("む", "mu"),
    Question ("め", "me"),
    Question ("も", "mo"),
    Question ("ら", "ra"),
    Question ("り", "ri"),
    Question ("る", "ru"),
    Question ("れ", "re"),
    Question ("ろ", "ro"),
    Question ("を", "wo"),
    Question ("ん", "n"),
    Question ("が", "ga"),
    Question ("ぎ", "gi"),
    Question ("ぐ", "gu"),
    Question ("げ", "ge"),
    Question ("ご", "go"),
    Question ("ざ", "za"),
    Question ("じ", "ji"),
    Question ("ず", "zu"),
    Question ("ぜ", "ze"),
    Question ("ぞ", "zo"),
    Question ("だ", "da"),
    Question ("ぢ", "dji"),
    Question ("づ", "dzu"),
    Question ("で", "de"),
    Question ("ど", "do"),
    Question ("ば", "ba"),
    Question ("び", "bi"),
    Question ("ぶ", "bu"),
    Question ("べ", "be"),
    Question ("ぼ", "bo"),
    Question ("ぱ", "pa"),
    Question ("ぴ", "pi"),
    Question ("ぷ", "pu"),
    Question ("ぺ", "pe"),
    Question ("ぽ", "po"),

    Question ("ア", "a"),
    Question ("イ", "i"),
    Question ("ウ", "u"),
    Question ("エ", "e"),
    Question ("オ", "o"),
    Question ("ヤ", "ya"),
    Question ("ユ", "yu"),
    Question ("ヨ", "yo"),
    Question ("ワ", "wa"),
    Question ("カ", "ka"),
    Question ("キ", "ki"),
    Question ("ク", "ku"),
    Question ("ケ", "ke"),
    Question ("コ", "ko"),
    Question ("サ", "sa"),
    Question ("シ", "shi"),
    Question ("ス", "su"),
    Question ("セ", "se"),
    Question ("ソ", "so"),
    Question ("タ", "ta"),
    Question ("チ", "chi"),
    Question ("ツ", "tsu"),
    Question ("テ", "te"),
    Question ("ト", "to"),
    Question ("ナ", "na"),
    Question ("ニ", "ni"),
    Question ("ヌ", "nu"),
    Question ("ネ", "ne"),
    Question ("ノ", "no"),
    Question ("ハ", "ha"),
    Question ("ヒ", "hi"),
    Question ("フ", "fu"),
    Question ("ヘ", "he"),
    Question ("ホ", "ho"),
    Question ("マ", "ma"),
    Question ("ミ", "mi"),
    Question ("ム", "mu"),
    Question ("メ", "me"),
    Question ("モ", "mo"),
    Question ("ラ", "ra"),
    Question ("り", "ri"),
    Question ("ル", "ru"),
    Question ("レ", "re"),
    Question ("ロ", "ro"),
    Question ("ヲ", "wo"),
    Question ("ン", "n"),
    Question ("ガ", "ga"),
    Question ("ギ", "gi"),
    Question ("グ", "gu"),
    Question ("ゲ", "ge"),
    Question ("ゴ", "go"),
    Question ("ザ", "za"),
    Question ("ジ", "ji"),
    Question ("ズ", "zu"),
    Question ("ゼ", "ze"),
    Question ("ゾ", "zo"),
    Question ("ダ", "da"),
    Question ("ヂ", "dji"),
    Question ("ヅ", "dzu"),
    Question ("デ", "de"),
    Question ("ド", "do"),
    Question ("バ", "ba"),
    Question ("ビ", "bi"),
    Question ("ブ", "bu"),
    Question ("ベ", "be"),
    Question ("ボ", "bo"),
    Question ("パ", "pa"),
    Question ("ピ", "pi"),
    Question ("プ", "pu"),
    Question ("ペ", "pe"),
    Question ("ポ", "po"),

  ];


  int _questionNumber = rng.nextInt(_questionBank.length);


  void initState (){
    Random random = new Random();
    _questionNumber = random.nextInt(_questionBank.length);

  }

  void nextQuestion(){
    Random random = new Random();
    _questionNumber = random.nextInt(_questionBank.length);
    if(_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText(){
    return _questionBank[_questionNumber].question;
  }

  String getCorrectAnswer(){
    return _questionBank[_questionNumber].answer;
  }
}


