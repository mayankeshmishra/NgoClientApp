import 'package:flutter/material.dart';
import 'package:donations/helpers/constants.dart';
class NgoCard{
  Container getCard(name){
    return Container(
                      decoration: profilePageLoginButtonGradient,
                      margin:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 0),

                      child: ListTile(
                        leading: Text(
                          name.toUpperCase(),
                          style:
                              TextStyle(fontSize: 18, color: Color(0xFFa7ffeb)),
                        ),
                        title: Text(
                          'Donate',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SourceSansPro',
                          ),
                          textAlign: TextAlign.right,
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.white,
                        ),
                      ),
                    );
  }
}