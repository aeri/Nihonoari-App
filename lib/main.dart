import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'dart:io';

void main() => runApp(Quizzler());

QuizBrain quizBrain = QuizBrain();

TextEditingController _controller = TextEditingController();

Color _result = Colors.white;


class Quizzler extends StatelessWidget {
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
  List<Widget> scoreKeeper = [];
  FocusNode myFocusNode;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
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
                  hintText: 'Enter romaji',
                   hintStyle: TextStyle(color: Colors.grey),

              ),
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
              onSubmitted: (value) {

                int control = 0;

                _controller.clear();

                String result = quizBrain.getCorrectAnswer();

                if (result == value.toLowerCase()) {
                  control = 500;
                  print("OK");
                  _result = Colors.green;
                }
                else{
                  control = 3000;
                  print ("NO");
                  _result = Colors.red;

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

                setState(() {
//                  scoreKeeper.add(
//                    Icon(
//                      Icons.close,
//                      color: Colors.red,
//                    ),
//                  );

                });

                Future.delayed(Duration(milliseconds: control), () {


                  setState(() {
                    _result = Colors.white;
                    quizBrain.nextQuestion();
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
