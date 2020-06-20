import 'package:flutter/material.dart';
class MakeTextBox{
  Widget makeTextBox(String hintText) {
    return TextField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),
            borderSide: BorderSide.none),
      ),
      onChanged: (value) {},
    );
  }
}