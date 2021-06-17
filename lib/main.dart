import 'package:flutter/material.dart';
import 'package:quiz_app/questionList.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

//TODO: Add app icon
//TODO: Make true / false expanded columns instead of rows, and move scores to top
//TODO: Add timer; when time runs out it's considered incorrect and move on
//TODO: Add speedy background music
//TODO: Increase true / false text size
//TODO: Make start screen instead of going straight into the quiz
//TODO: Add different sounds to correct / incorrect answer
//TODO: After completion, tally up the scores and notify the user

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

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
  const QuizPage({Key? key}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

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

class _QuizPageState extends State<QuizPage> {
  List<Icon> scores = [];
  QuestionList questionList = new QuestionList();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              questionList.getQuestionText(),
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  setState(() {
                    scores.add(
                        getScoreIcon(state: questionList.getAnswer() == true));
                    questionList.getNext();
                    if (questionList.isFinished()) {
                      Alert(
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
                          ]).show();
                    }
                  });
                },
                child: Text(
                  'True',
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () {
                  setState(() {
                    scores.add(
                        getScoreIcon(state: questionList.getAnswer() == false));
                    questionList.getNext();
                    if (questionList.isFinished()) {
                      Alert(
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
                          ]).show();
                    }
                  });
                },
                child: Text(
                  'False',
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
        Row(
          children: scores,
        )
      ],
    );
  }
}
