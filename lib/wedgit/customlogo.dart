import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Image(
                      image: AssetImage('images/icons/7.png'),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Text(
                      "Let\'s Shopping",
                      style: TextStyle(
                          color: Colors.blue[900],
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
  }
}