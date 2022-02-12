import 'dart:async';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';
import "dart:math";

class Game extends StatefulWidget {
  Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  var _highscore;
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

  Future<void> highscoreset(var n) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('highscore', n);
  }

  Future<int> highscoreread() async {
    final prefs = await SharedPreferences.getInstance();
    final n = prefs.getInt('highscore');
    if (n == null)
      _highscore = 0;
    else
      _highscore = n.toInt();
    return 0;
  }

// set value

  int _high = 0;
  int level = 1;
  int limit = 0;
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
    ps_over();
    setState(() {
      _timer.cancel();
      var gamescore = counter;
      over = "Game over\nYour score : $gamescore";
      _high = gamescore;
      counter = 0;
      nameofcolor = " ";
      _controller.text = "";
      score = "";
      if (gamescore > _highscore) {
        highscoreset(gamescore);
        _highscore = gamescore;
      }
    });
  }

  void gamestart() {
    ps_start();
    level = 1;
    limit = 5;
    score = "Score : $counter";
    istime = true;
    randomNumber = random.nextInt(limit);
    textran = random.nextInt(limit);
    textname = texts[textran];
    nameofcolor = textname;
    clr = clrs[randomNumber];
    highscoreread();
  }

  void gamerun() {
    String input = _controller.text.toLowerCase();
    input = input.replaceAll(' ', '');
    print(input);
    if (tclrs[input] == clr && istime) {
      ps_point();
      over = " ";
      counter++;
      score = "Score : $counter";
      countdown += 3;
      if (counter == 10 || counter == 20) ps_level();
      if (counter < 10) {
        level = 1;
        limit = 5;
        randomNumber = random.nextInt(limit);
        textran = random.nextInt(limit);
      } else if (counter < 20) {
        level = 2;
        limit = 9;
        randomNumber = random.nextInt(limit);
        textran = random.nextInt(limit);
      } else {
        level = 3;
        limit = texts.length;
        randomNumber = random.nextInt(limit);
        textran = random.nextInt(limit);
      }
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

  void ps_start() {
    AudioCache player = new AudioCache();
    const pointsound = "gamestart.mp3";
    player.play(pointsound);
  }

  void ps_point() {
    AudioCache player = new AudioCache();
    const pointsound = "point.mp3";
    player.play(pointsound);
  }

  void ps_level() {
    AudioCache player = new AudioCache();
    const pointsound = "levelup.mp3";
    player.play(pointsound);
  }

  void ps_over() {
    AudioCache player = new AudioCache();
    const pointsound = "gameover.mp3";
    player.play(pointsound);
  }

  static const clrs = <Color>[
    Colors.red,
    Colors.white,
    Colors.purple,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.grey,
    Colors.orange,
    Colors.cyan,
    Colors.pink,
    Colors.brown,
    Colors.lime,
    Colors.teal,
  ];
  static const tclrs = {
    "red": Colors.red,
    "white": Colors.white,
    "purple": Colors.purple,
    "green": Colors.green,
    "yellow": Colors.yellow,
    "blue": Colors.blue,
    "grey": Colors.grey,
    "orange": Colors.orange,
    "cyan": Colors.cyan,
    "pink": Colors.pink,
    "brown": Colors.brown,
    "lime": Colors.lime,
    "teal": Colors.teal,
  };
  static const texts = [
    "red",
    "white",
    "purple",
    "green",
    "yellow",
    "blue",
    "grey",
    "orange",
    "cyan",
    "pink",
    "brown",
    "lime",
    "teal",
  ];

  String buttonstate = "Start";
  static Random random = new Random();
  static int randomNumber = random.nextInt(texts.length);
  static String textname = texts[textran];
  var nameofcolor = " ";
  static var textran = random.nextInt(texts.length);
  Color clr = clrs[randomNumber];
  var counter = 0;
  var over = " ";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "game",
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            backgroundColor: Colors.black87,
            title: Row(
              children: [
                Text("Game of Colors"),
                Spacer(),
                PopupMenuButton(
                  color: Colors.black87,
                  icon: Icon(Icons.dehaze),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        child: TextButton(
                      onPressed: () {
                        setState(() {
                          dialog_HTP(context);
                        });
                      },
                      child: Text('How to Play'),
                    )),
                    PopupMenuItem(
                        child: TextButton(
                      onPressed: () {
                        colorslist(
                          context,
                        );
                      },
                      child: Text('Color List'),
                    ))
                  ],
                ),
              ],
            )),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xFF000000),
                  Color(0xFF2d3436),
                ],
              )),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Time : $countdown",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Level : $level",
                  style: TextStyle(fontSize: 30, color: Colors.white54),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  color: Colors.black54,
                  width: 170,
                  height: 70,
                  child: Text(
                    nameofcolor,
                    style: TextStyle(fontSize: 50, color: clr),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _controller,
                  textAlign: TextAlign.center,
                  onSubmitted: (value) {
                    setState(() {
                      gamerun();
                    });
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.white60),
                    border: OutlineInputBorder(),
                    labelText: 'enter the text color',
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10.0),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  over,
                  style: TextStyle(fontSize: 30, color: Colors.white54),
                ),
                Text(
                  score,
                  style: TextStyle(fontSize: 30, color: Colors.white54),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black38,
                    ),
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
                Text(
                  'Highscore :  $_highscore',
                  style: (TextStyle(fontSize: 20, color: Colors.white54)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> colorslist(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: Text("Colors"),
          content: Container(
            width: 100,
            height: 150,
            child: SingleChildScrollView(
              child: Column(children: [
                Text(
                  "Lvel 1",
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    colorRow(Colors.red, "red"),
                    Spacer(),
                    colorRow(Colors.white, "white"),
                  ],
                ),
                Row(
                  children: [
                    colorRow(Colors.purple, "purple"),
                    Spacer(),
                    colorRow(Colors.green, "green"),
                  ],
                ),
                Row(
                  children: [
                    colorRow(Colors.yellow, "yellow"),
                    Spacer(),
                    colorRow(Colors.blue, "blue  "),
                  ],
                ),
                Text(
                  "Lvel 2",
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    colorRow(Colors.grey, "grey"),
                    Spacer(),
                    colorRow(Colors.orange, "orange"),
                  ],
                ),
                Row(
                  children: [
                    colorRow(Colors.cyan, "cyan"),
                    Spacer(),
                    colorRow(Colors.pink, "pink     "),
                  ],
                ),
                Text(
                  "Lvel 3",
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    colorRow(Colors.brown, "brown"),
                    Spacer(),
                    colorRow(Colors.lime, "lime"),
                  ],
                ),
                Row(
                  children: [
                    colorRow(Colors.teal, "teal"),
                    Spacer(),
                  ],
                ),
              ]),
            ),
          ),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Future<dynamic> dialog_HTP(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("HOW TO PLAY"),
          content: Container(
            width: 100,
            height: 150,
            child: Column(
              children: [
                Text("Enter the Color of the given text\n For example :\n"),
                Text("If the given text is :"),
                Text(
                  "blue",
                  style: TextStyle(color: Colors.red),
                ),
                Text("Enter red")
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }
}

class colorRow extends StatelessWidget {
  colorRow(this.c, this.s);
  Color c;
  var s;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          color: c,
        ),
        Text(s)
      ],
    );
  }
}
