import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'table.dart';

//void main() => runApp(Party());

Color _result = Colors.white;

class Party extends StatefulWidget {

  final bool h, k;

  Party({@required this.h, @required this.k});

  @override
  _Party createState() => _Party(h, k);
}

class _Party extends State<Party> {

  _Party(h, k) {
    QuizBrain.setList(h, k);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

  TextEditingController _controller = TextEditingController();

  List<Widget> scoreKeeper = [];
  FocusNode myFocusNode;
  int total = 0;
  int accepted = 0;
  int rejected = 0;
  double ratio = 0;

  @override
  void initState() {
    super.initState();

    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    myFocusNode.dispose();

    super.dispose();
  }

  void _showDialog() async{
    // flutter defined function
    Scaffold.of(context).hideCurrentSnackBar();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Statistics"),
          content: new Text("Total: $total\n"
              "Passed: $accepted\n"
              "Failed: $rejected\n"
              "Success rate: ${ratio.toStringAsFixed(2)}%"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
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
                    onPressed: () { Navigator.push(
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
                    onPressed: () { _showDialog(); }
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
              focusNode: myFocusNode,
              autofocus: true,
              textAlign: TextAlign.center ,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hoverColor: Colors.white,
                fillColor: Colors.white,
                focusColor: Colors.white,
                  border: InputBorder.none,
                  hintText: 'Enter rōmaji',
                   hintStyle: TextStyle(color: Colors.grey),

              ),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              onSubmitted: (value) {

                int control = 0;

                _controller.clear();

                String result = QuizBrain.currentQuestion.answer;

                ++total;

                if (result == value.toLowerCase()) {
                  control = 500;
                  print("OK");
                    _result = Colors.green;
                  ++accepted;
                }
                else{
                  control = 3000;
                  print ("NO");
                  _result = Colors.red;
                  ++rejected;

                  final snackBar = SnackBar(
                    elevation: 10,
                    duration: Duration(milliseconds: control) ,
                    content: Text('Correct answer: $result',
                      style: TextStyle(
                        fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),


                  );

                  Scaffold.of(context).showSnackBar(snackBar);

                }

                ratio = (accepted/total)*100;

                setState(() {
//
                });

                Future.delayed(Duration(milliseconds: control), () {


                  setState(() {
                    _result = Colors.white;
                    QuizBrain.nextQuestion();
                    FocusScope.of(context).requestFocus(myFocusNode);
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
