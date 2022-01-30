import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import "dart:math";

class Game extends StatefulWidget {
  Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String score = "";
  int countdown = 8;
  late Timer _timer;
  bool istime = true;
  bool sos = true;
  void countdowntimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown -= 1;
        });
      } else {
        istime = false;
        setState(() {
          gamerun();
        });
      }
    });
  }

  void gameover() {
    setState(() {
      _timer.cancel();
      over = "Game over\nYour score : $counter";
      counter = 0;
      nameofcolor = " ";
      _controller.text = "";
      score = "";
    });
  }

  void gamestart() {
    score = "Score : $counter";
    istime = true;
    randomNumber = random.nextInt(texts.length);
    textran = random.nextInt(texts.length);
    textname = texts[textran];
    nameofcolor = textname;
    clr = clrs[randomNumber];
  }

  void gamerun() {
    String input = _controller.text.toLowerCase();
    if (tclrs[input] == clr && istime) {
      over = " ";
      counter++;
      score = "Score : $counter";
      countdown += 3;
      randomNumber = random.nextInt(texts.length);
      textran = random.nextInt(texts.length);
      textname = texts[textran];
      nameofcolor = textname;
      clr = clrs[randomNumber];
      _controller.clear();
    } else {
      gameover();
    }
  }

  void resetgame() {
    setState(() {
      over = " ";
      counter = 0;
      _timer.cancel();
      countdown = 8;

      nameofcolor = " ";
    });
  }

  static const clrs = <Color>[
    Colors.red,
    Colors.black,
    Colors.purple,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.grey,
    Colors.orange,
  ];
  static const tclrs = {
    "red": Colors.red,
    "black": Colors.black,
    "purple": Colors.purple,
    "green": Colors.green,
    "yellow": Colors.yellow,
    "blue": Colors.blue,
    "grey": Colors.grey,
    "orange": Colors.orange,
  };
  static const texts = [
    "red",
    "black",
    "purple",
    "green",
    "yellow",
    "blue",
    "grey",
    "orange"
  ];
  String buttonstate = "Start";
  static Random random = new Random();
  static int randomNumber = random.nextInt(texts.length);
  static String textname = texts[textran];
  var nameofcolor = " ";
  static var textran = random.nextInt(texts.length);
  Color clr = clrs[randomNumber];
  int counter = 0;
  var over = " ";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "game",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Game of Colors"),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text("Time : $countdown"),
                SizedBox(
                  height: 20,
                ),
                Text(
                  nameofcolor,
                  style: TextStyle(fontSize: 50, color: clr),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  onSubmitted: (value) {
                    setState(() {
                      gamerun();
                    });
                  },
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  over,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  score,
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (sos) {
                        countdowntimer();
                        gamestart();
                      } else
                        resetgame();
                      sos = !sos;

                      setState(() {
                        if (sos)
                          buttonstate = "Start";
                        else
                          buttonstate = "Restart";
                      });
                    },
                    child: Text(buttonstate)),
                Container()
              ],
            )
          ],
        ),
      ),
    );
  }
}
