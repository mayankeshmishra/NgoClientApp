import 'package:flutter/material.dart';
import 'dart:ui';

class MakeCard {
  ClipRRect getCard({deviceWidth, deviceHeight, imagename, type}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width:deviceWidth/2.5,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
              image: AssetImage('assets/${imagename}'), fit: BoxFit.fill),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 0.0,
            sigmaY: 0.0,
          ),
          child: Container(
            decoration: new BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topRight,
              colors: <Color>[
                Colors.white.withOpacity(1),
                Colors.white.withOpacity(0.6),
                Colors.white.withOpacity(0.2),
                Color(0x00897b),
                Color(0x00897b),
              ],
            )),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(type,
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF004d40))),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Text("NGO\'s",
                        style:
                            TextStyle(fontSize: 32, color: Color(0xFF26a69a))),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
