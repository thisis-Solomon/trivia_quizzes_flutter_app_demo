import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_quizzes_flutter_app_demo/provider/home_page_provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  double? _deviceWidth, _deviceHeight;
  HomePageProvider? _pageProvider;

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (context) {
        return HomePageProvider(context: context);
      },
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(
      builder: (context) {
        _pageProvider = context.watch<HomePageProvider>();
        if (_pageProvider!.questions != null) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: _deviceHeight! * 0.05,
                  horizontal: _deviceWidth! * 0.04,
                ),
                child: _questionUI(),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _questionUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _questionText(),
        SizedBox(height: 16),
        Column(
          children: [
            _trueButton(),
            SizedBox(height: _deviceHeight! * 0.01),
            _falseButton(),
          ],
        ),
      ],
    );
  }

  Widget _questionText() {
    return Text(
      _pageProvider!.getCurrentQuestion(),
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: Colors.grey[50],
      ),
    );
  }

  Widget _trueButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider!.getAnswerQuestion("True");
      },
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      color: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        "True",
        style: TextStyle(color: Colors.grey[50], fontSize: 24),
      ),
    );
  }

  Widget _falseButton() {
    return MaterialButton(
      onPressed: () {
        _pageProvider!.getAnswerQuestion("False");
      },
      minWidth: _deviceWidth! * 0.80,
      height: _deviceHeight! * 0.10,
      color: Colors.redAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(
        "False",
        style: TextStyle(color: Colors.grey[50], fontSize: 24),
      ),
    );
  }
}
