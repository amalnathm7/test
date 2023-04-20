import 'package:flutter/material.dart';
import 'package:r_quiz/main.dart';
import 'package:r_quiz/vision_detector_views/detector_views.dart';
import '/data/questions_example.dart';
import '/screens/result_screen.dart';
import '/ui/shared/color.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> {
  int questionPos = 0;
  int score = 0;
  PageController? _controller;
  String btnText = "Next Question";
  bool answered = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
    changer.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.pripmaryColor,
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: PageView.builder(
                  controller: _controller!,
                  onPageChanged: (page) {
                    if (page == questions.length - 1) {
                      setState(() {
                        btnText = "See Results";
                      });
                    }
                    setState(() {
                      answered = false;
                    });
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            "Question ${index + 1}/10",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28.0,
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 100.0,
                          child: Text(
                            "${questions[index].question}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                            ),
                          ),
                        ),
                        for (int i = 0;
                            i < questions[index].answers!.length;
                            i++)
                          Container(
                            width: double.infinity,
                            height: 50.0,
                            margin: const EdgeInsets.only(
                                bottom: 20.0, left: 12.0, right: 12.0),
                            child: RawMaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              fillColor: changer.btnPressed != -1
                                  ? questions[index]
                                          .answers!
                                          .values
                                          .toList()[i]
                                      ? Colors.green
                                      : Colors.red
                                  : changer.selectedOpt == i
                                      ? AppColor.secondaryColor
                                      : Colors.grey,
                              onPressed: !answered
                                  ? () {
                                      if (questions[index]
                                          .answers!
                                          .values
                                          .toList()[i]) {
                                        score++;
                                        print("yes");
                                      } else {
                                        print("no");
                                      }

                                      changer.btnPressed = i;
                                      changer.notify();
                                      answered = true;
                                    }
                                  : null,
                              child: Text(
                                  questions[index].answers!.keys.toList()[i],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  )),
                            ),
                          ),
                        const SizedBox(
                          height: 40.0,
                        ),
                        RawMaterialButton(
                          onPressed: () {
                            if (_controller!.page?.toInt() ==
                                questions.length - 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ResultScreen(score)));
                            } else {
                              _controller!.nextPage(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.easeInExpo);

                              changer.btnPressed = -1;
                              changer.notify();
                            }
                          },
                          shape: const StadiumBorder(),
                          fillColor: Colors.blue,
                          padding: const EdgeInsets.all(18.0),
                          elevation: 0.0,
                          child: Text(
                            btnText,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(
                          height: 40.0,
                        ),
                      ],
                    );
                  },
                  itemCount: questions.length,
                ),
              ),
            ),
            Flexible(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: const PoseDetectorView(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
