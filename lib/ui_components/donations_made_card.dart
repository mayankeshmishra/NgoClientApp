import 'package:flutter/material.dart';
class DonationsMade{
  Card getCard({amount,organisation}){
    return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 2, horizontal: 10),

                      child: ListTile(
                        leading: Text(
                          '₹ $amount Donated to $organisation',
                          style: TextStyle(
                            color:Color(0xFF004d40),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SourceSansPro',
                          ),
                          textAlign: TextAlign.right,
                        ),
                        trailing: Icon(
                          Icons.keyboard_arrow_right,
                          color: Color(0xFF4db6ac),
                        ),
                      ),
                    );
  }
}