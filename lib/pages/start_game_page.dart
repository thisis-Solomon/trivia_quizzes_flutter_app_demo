import "package:flutter/material.dart";
import "package:trivia_quizzes_flutter_app_demo/pages/home_page.dart";

class StartGamePage extends StatefulWidget {
  const StartGamePage({super.key});
  @override
  State<StartGamePage> createState() => _StartGamePageState();
}

class _StartGamePageState extends State<StartGamePage> {
  double? _widthDevice, _heightDevice;
  double _currentDifficultLevel = 0.0;

  final List<String> difficultLevelText = ["Easy", "Medium", "Hard"];

  @override
  Widget build(BuildContext context) {
    _heightDevice = MediaQuery.of(context).size.height;
    _widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: _heightDevice! * 0.05,
            horizontal: _widthDevice! * 0.05,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [_appTitle(), _difficultyLevelSlider(), _startGame()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appTitle() {
    return Column(
      children: [
        Text(
          "Trivia Quizzes",
          style: TextStyle(
            fontSize: _widthDevice! * 0.1,
            fontWeight: FontWeight.bold,
            color: Colors.grey[50],
          ),
        ),
        Text(
          difficultLevelText[_currentDifficultLevel.toInt()],
          style: TextStyle(
            fontSize: _widthDevice! * 0.06,
            fontWeight: FontWeight.w500,
            color: Colors.grey[200],
          ),
        ),
      ],
    );
  }

  Widget _difficultyLevelSlider() {
    return Slider(
      value: _currentDifficultLevel,
      min: 0,
      max: 2,
      divisions: 2,
      label: "Level",
      onChanged: (value) {
        setState(() {
          _currentDifficultLevel = value;
        });
      },
    );
  }

  Widget _startGame() {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
            },
          ),
        );
      },
      minWidth: _widthDevice! * 0.80,
      height: _heightDevice! * 0.08,
      color: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        "Start",
        style: TextStyle(color: Colors.grey[50], fontSize: 24),
      ),
    );
  }
}
