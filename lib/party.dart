import 'package:Nihonoari/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localizations.dart';
import 'quiz_brain.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'table.dart';

//void main() => runApp(Party());

Color _result = Colors.white;

class Party extends StatefulWidget {

  final bool h, k;

  final Map<String, dynamic> hv, kv;

  Party({@required this.h, @required this.hv, @required this.k, @required this.kv});

  @override
  _Party createState() => _Party(h, hv, k, kv);
}

class _Party extends State<Party> {

  _Party(h, hv, k, kv) {

    setHiraganaSet(hv);
    setKatakanaSet(kv);

    QuizBrain.setList(h, hv, k, kv);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: [
        Locale('en', 'US'),
        Locale('es', ''),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  FocusNode _focusNode = FocusNode();

  bool _ignore = false;

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

  void _showDialog() async{
    // flutter defined function
    Scaffold.of(context).hideCurrentSnackBar();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.black,
          title: new Text(AppLocalizations.of(context).translate('quiz_stats'),
              style: TextStyle(
                color: Colors.white,
              )),
          content: new Text(
              "${AppLocalizations.of(context).translate('quiz_total')}: $total\n"
              "${AppLocalizations.of(context).translate('quiz_passed')}: $accepted\n"
              "${AppLocalizations.of(context).translate('quiz_failed')}: $rejected\n"
              "${AppLocalizations.of(context).translate('quiz_rate')}: ${ratio.toStringAsFixed(2)}%",
              style: TextStyle(
                color: Colors.white,
              )),

          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
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
    return Column(
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
                    icon: new Icon(
                        FontAwesomeIcons.language,
                        color: Colors.white),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BasicGridView()),
                    ); }
                )
              ),
              Expanded(
                child: IconButton(
                  // Use the FontAwesomeIcons class for the IconData
                    icon: new Icon(
                        FontAwesomeIcons.chartBar,
                        color: Colors.white),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      _showDialog(); }
                )
              ),

            ],
          )
        ),
        Expanded(
          flex: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                QuizBrain.currentQuestion.question,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'AppleTP',
                  fontSize: 150.0,
                  color: _result,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextField(
              textInputAction: TextInputAction.done,
              controller: _controller,
              focusNode: _focusNode,
              autofocus: true,
              textAlign: TextAlign.center ,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hoverColor: Colors.white,
                fillColor: Colors.white,
                focusColor: Colors.white,
                  border: InputBorder.none,
                  hintText: AppLocalizations.of(context).translate('quiz_enter'),
                   hintStyle: TextStyle(color: Colors.grey),

              ),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              onSubmitted: (value) {

                if (_ignore || value.length < 1){
                  return;
                }
                _ignore = true;

                int control = 0;
                bool passed;


                _controller.clear();

                String result = QuizBrain.currentQuestion.answer;

                ++total;

                setState(() {
                  if (result == value.toLowerCase()) {
                    control = 500;
                    print("OK");
                    _result = Colors.green;
                    ++accepted;
                    passed = true;
                  }
                  else{
                    control = 2000;
                    print ("NO");
                    _result = Colors.red;
                    ++rejected;
                    passed = false;

                    final snackBar = SnackBar(
                      elevation: 10,
                      duration: Duration(milliseconds: control) ,
                      content: Text('${AppLocalizations.of(context).translate('quiz_correct')}: $result',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),


                    );

                    Scaffold.of(context).showSnackBar(snackBar);

                  }
                });



                ratio = (accepted/total)*100;



                Future.delayed(Duration(milliseconds: control), () {


                  setState(() {
                    _result = Colors.white;
                    QuizBrain.nextQuestion(passed);
                    _ignore = false;
                  });

                });




              },
            )

          ),
        ),

        Expanded(
          child: Row(
            children: scoreKeeper,
          ),
        ),
      ],
    );
  }
}
