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
                      text: "  Welcome to SafeGo \n",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                      children: [
                        TextSpan(
                          text: 'Login Before you start your trip! \n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        TextSpan(
                          text: '\nUSER LOCATION DATA GOES HERE!!!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.white,
                  ),
                  RichText(
                      textAlign: TextAlign.left,
                      text: const TextSpan(
                        text: "  \n \nLogin Credentials \n",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                BorderSide(width: 2, color: Colors.grey)),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Username",
                        fillColor: Colors.white70,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide:
                                BorderSide(width: 1, color: Colors.white)),
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: "Password",
                        fillColor: Colors.white70,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(5.0),
                      child: SizedBox(
                          width: 251,
                          height: 40,
                          child: ElevatedButton(
                            onPressed: () {
                              debugPrint('ElevatedButton Clicked');
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                          )))
                ],
              )),
        ),
      ],
    )))),
  );
}
