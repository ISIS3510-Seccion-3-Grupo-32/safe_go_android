import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
        home: Scaffold(
            body: Align(
                child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          alignment: Alignment.topCenter,
          height: 400.0,
          width: 800.0,
          color: Colors.transparent,
          child: Container(
              decoration: const BoxDecoration(
                  color: Color(0xFF96CEB4),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Column(
                children: [
                  RichText(
                    text: const TextSpan(
                      text: " -Travel Name Goes Here- \n",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                      children: [],
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  Container(
                    height: 150.0,
                    width: 500.0,
                    color: Colors.transparent,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: new Center(
                          child: new Text(
                            "The rest of the travel data goes here :)",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ),
                ],
              )),
        ),
      ],
    )))),
  );
}
