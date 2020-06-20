import 'package:flutter/material.dart';

class MonthlyDonations{
  Widget getListTile({amount}){
    return ListTile(
                        leading: Text(
                          "THIS MONTH",
                          style: TextStyle(fontSize: 18, color: Color(0xFFcfd8dc)),
                        ),
                        title: Text(
                          '₹$amount',
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
                      );
  }
}