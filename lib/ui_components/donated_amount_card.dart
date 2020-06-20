import 'package:flutter/material.dart';
class DonatedAmountCard{
  Widget getCard({amount,amountType}){
    return Card(
                              color: Colors.white,
                              margin: EdgeInsets.all(10),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      '₹$amount',
                                      style: TextStyle(
                                          color: Colors.tealAccent[400],
                                          fontSize: 40,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'SourceSansPro'),
                                    ),
                                    Text(
                                      amountType,
                                      style: TextStyle(
                                          color: Color(0xFF00695c),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'SourceSansPro'),
                                    ),
                                  ],
                                ),
                              ),
                            );
  }
}