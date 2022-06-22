import 'dart:async';

import 'package:flutter/material.dart';
import 'package:p11/auth/fireclass.dart';
import 'package:p11/auth/home.dart';
import 'package:p11/main.dart';

class Splesh extends StatefulWidget {
  const Splesh({Key? key}) : super(key: key);

  @override
  State<Splesh> createState() => _SpleshState();
}

class _SpleshState extends State<Splesh> {
  @override
  Widget build(BuildContext context) {
    check(context);
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  void check(BuildContext context) {
    if(Auth().currentUser(context)==true)
      {
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (c) {
                return HOMESCREEN();
              },
            ),
          );
        });
      }
    else
      {
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (c) {
                return Myapp();
              },
            ),
          );
        });
      }
  }
}
