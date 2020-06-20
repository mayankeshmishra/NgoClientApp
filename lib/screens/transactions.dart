
import 'package:flutter/material.dart';

import 'package:donations/helpers/constants.dart';
import '../ui_components/bottom_app_bar.dart';
import 'package:donations/helpers/clip_path.dart';
import '../ui_components/donations_made_card.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  ClipPathClass clip = ClipPathClass();
  BottomAppBarClass appBar = BottomAppBarClass();
  DonationsMade card= DonationsMade();
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        bottomNavigationBar: appBar.getAppBar(context: context),
        body: Container(
          decoration: gradient,
          width: deviceWidth,
          child: Column(
            children: <Widget>[
              Card(
                color: Color(0xFF00796B),
                child: Container(
                  width: deviceWidth - 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        "TOTAL DONATIONS MADE",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "WorldWide",
                        style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "₹50,00,000",
                        style: TextStyle(
                            fontSize: 45,
                            color: Color(0xFF64ffda),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 15)
                    ],
                  ),
                ),
              ),
              
              SizedBox(height:10),
              Expanded(child: ListView(children: <Widget>[
                card.getCard(amount:50000, organisation:"xxx"),
                card.getCard(amount:20000, organisation:"yyy"),
                card.getCard(amount:25000, organisation:"zzz"),
                card.getCard(amount:40000, organisation:"xxx"),
                card.getCard(amount:30000, organisation:"yyy"),
                card.getCard(amount:10000, organisation:"zzz"),
                card.getCard(amount:60000, organisation:"xxx"),
                card.getCard(amount:10000, organisation:"yyy"),
              ],),)
              
            ],
          ),
        ),
      ),
    );
  }
}
