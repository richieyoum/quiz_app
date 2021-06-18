import 'package:flutter/material.dart';
import 'package:quiz_app/questionList.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:quiz_app/playSound.dart';

//TODO: Dedicate space for scores at start instead of pushing up everything
//TODO: Add timer; when time runs out it's considered incorrect and move on
//TODO: Add speedy background music
//TODO: Make start screen instead of going straight into the quiz
//TODO: After completion, tally up the scores and notify the user

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
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
  List<Icon> scores = [];
  QuestionList questionList = new QuestionList();

  Icon getScoreIcon({bool state: true}) {
    if (state) {
      return Icon(
        Icons.check,
        color: Colors.green,
      );
    }
    return Icon(
      Icons.close,
      color: Colors.red,
    );
  }

  Alert endAlert(BuildContext context) {
    finishSound();
    return Alert(
        context: context,
        title: "Quiz is over!",
        desc: "Thanks for playing :)",
        buttons: [
          DialogButton(
              child: Text(
                "Play again!",
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.green,
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                  questionList.resetIdx();
                  scores = [];
                });
              })
        ]);
  }

  @override
  Widget build(BuildContext context) {
    bool isCorrect;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Center(
            child: Text(
              questionList.getQuestionText(),
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                            vertical: 50.0, horizontal: 30.0)),
                    onPressed: () {
                      setState(() {
                        if (!questionList.isFinished()) {
                          isCorrect = questionList.getAnswer() == true;
                          answerSound(isCorrect);
                          scores.add(getScoreIcon(state: isCorrect));
                        }
                        questionList.getNext();
                        if (questionList.isFinished()) {
                          endAlert(context).show();
                        }
                      });
                    },
                    child: Text(
                      'True',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: EdgeInsets.symmetric(
                            vertical: 50.0, horizontal: 30.0)),
                    onPressed: () {
                      setState(() {
                        if (!questionList.isFinished()) {
                          isCorrect = questionList.getAnswer() == false;
                          answerSound(isCorrect);
                          scores.add(getScoreIcon(state: isCorrect));
                        }
                        questionList.getNext();
                        if (questionList.isFinished()) {
                          endAlert(context).show();
                        }
                      });
                    },
                    child: Text(
                      'False',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    )),
              ),
            )
          ],
        ),
        Row(
          children: scores,
        ),
      ],
    );
  }
}
