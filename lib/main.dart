import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizi_flutter/Quiz-Brain.dart';
//TODO: Step 2 - Import the rFlutter_Alert package here.
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: (AppBar(
          backgroundColor: Colors.deepOrange,
        )),
        body: Quizi(),
      ),
    ),
  );
}
//

class Quizi extends StatefulWidget {
  @override
  _QuiziState createState() => _QuiziState();
}

class _QuiziState extends State<Quizi> {
  List<Icon> scoreKeeper = []; //This is the list where the score is going to enter
  void checkAnswer(bool userPickedAnswer){
    bool correctAnswer = quizBrain.getCorrectAnswer();

    setState(() {
      //TODO: Step 4 - Use IF/ELSE to check if we've reached the end of the quiz. If so,
      //On the next line, you can also use if (quizBrain.isFinished()) {}, it does the same thing.
      if (quizBrain.isFinished() == true) {
        //TODO Step 4 Part A - show an alert using rFlutter_alert,

        //This is the code for the basic alert from the docs for rFlutter Alert:
        //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

        //Modified for our purposes:
        Alert(
          context: context,
          title: 'Finished!',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        //TODO Step 4 Part C - reset the questionNumber,
        quizBrain.reset();

        //TODO Step 4 Part D - empty out the scoreKeeper.
        scoreKeeper = [];
      }

      //TODO: Step 6 - If we've not reached the end, ELSE do the answer checking steps below 👇
      else {
        if (userPickedAnswer == correctAnswer) {
          scoreKeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          scoreKeeper.add(Icon(
            Icons.close,
            color: Colors.red,
          ));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  SizedBox space() {
    return SizedBox(
      height: 20.0,
    );
  }

  QuizBrain quizBrain = QuizBrain();

  // List<String> questions = [
  //   "My name is tushar",
  //   "My mother name is krishan",
  //   "my sister name is bhoomi"
  // ];
  // List<bool> answers = [
  //   true,
  //   false,
  //   true
  // ];
  //
  // Question q1= Question(q: "My name is tushar",a: true);


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                quizBrain.getQuestionText(),
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 300.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: FlatButton(
            height: 50.0,
            color: Colors.green,
            child: Text(
              "True",
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {
               checkAnswer(true);
            },
          ),
        ),
        space(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: FlatButton(
            color: Colors.red,
            height: 50.0,
            child: Text(
              "False",
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
            onPressed: () {
              checkAnswer(false);
            },
          ),
        ),
        space(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            children: scoreKeeper,
          ),
        ),
        space(),
      ],
    );
    //TODO: Add list
  }
}

// Center(
// child: Text("Yor question here !"),
// ),
