import 'package:flutter/material.dart';
import '/screens/quiz_screen.dart';
import '/ui/shared/color.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColor.pripmaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 48.0,
            horizontal: 12.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  "Quiz App",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: RawMaterialButton(
                    onPressed: () {
                      //Navigating the the Quizz Screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const QuizScreen(),
                          ));
                    },
                    shape: const StadiumBorder(),
                    fillColor: AppColor.secondaryColor,
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                      child: Text(
                        "Start the Quiz",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
