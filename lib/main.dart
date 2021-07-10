import 'package:flutter/material.dart';

import 'dart:async';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'STOPWATCH',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var seconds = 0;
  var minutes = 0;
  var milliseconds = 0;
  Timer timer;

  void start() {
    timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      setState(() {
        milliseconds++;
        if (milliseconds == 1000) {
          seconds++;
          milliseconds = 0;
        } else if (seconds == 60) {
          minutes++;
          seconds = 0;
        }
      });
    });
  }

  void cancel() {
    setState(() {
      timer.cancel();
      minutes = 0;
      seconds = 0;
      milliseconds = 0;
    });
  }

  void stop() {
    timer.cancel();
  }

  void resume() {
    start();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Container(
              height: 150,
              width: double.infinity,
              child: stopWatch(),
            ),
            SizedBox(
              height: 100,
            ),
            Expanded(
              child: Container(child: myWidget()),
            )
          ],
        ),
      ),
    );
  }

  Widget stopWatch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          '$minutes'.padLeft(2, '0'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
        ),
        Text(
          ':',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
        ),
        Text(
          '$seconds'.padLeft(2, '0'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
        ),
        Text(
          '.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
        ),
        Text(
          '$milliseconds'
              .padLeft(
                2,
                '0',
              )
              .substring(0, 2),
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
        ),
      ],
    );
  }

  Widget myWidget() {
    final isRunning = timer == null ? false : timer.isActive;
    final isexit =
        minutes == 0 && seconds == 0 && milliseconds == 0 ? false : true;
    return isRunning
        ? Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.purple,
                      onPressed: stop,
                      child: Text(
                        'STOP',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 40)),
                  Container(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.purple,
                      onPressed: cancel,
                      child: Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ]),
          )
        : Center(
            child: isexit
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Container(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.purple,
                            onPressed: resume,
                            child: Text(
                              'RESUME',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 40)),
                        Container(
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Colors.purple,
                            onPressed: cancel,
                            child: Text(
                              'CANCEL',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ])
                : Container(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Colors.purple,
                      onPressed: start,
                      child: Text(
                        'START',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
          );
  }
}
