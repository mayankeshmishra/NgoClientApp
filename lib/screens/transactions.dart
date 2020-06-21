import 'package:donations/screens/show_transaction_image.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

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
  DonationsMade card = DonationsMade();
  int transactionTotal=0;
  List<String> transactions = [];
  List<String> ngoName = [];
  List<String> transactionsImageUrl=[];

  void initState() {
    super.initState();

    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("Transactions");
    postsRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      transactions.clear();
      ngoName.clear();
      transactionsImageUrl.clear();

      for (var indivisualKey in KEYS) {
        print(DATA[indivisualKey]['amount']);
        ngoName.add(DATA[indivisualKey]['name']);
        transactions.add(DATA[indivisualKey]['amount']);
        transactionsImageUrl.add(DATA[indivisualKey]['image']);
      }
      setState(() {
        transactionTotal=transactions.fold(0, (p, c) => p + int.parse(c));
      });
    });
  }

  Widget listBuilderTransactionList(BuildContext context) {
    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
              child: card.getCard(
                  amount: transactions[i], organisation: ngoName[i]),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ShowTransactionDetails(transactionsImageUrl[i])));
              });
        });
  }

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
                        transactionTotal.toString(),
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
              SizedBox(height: 10),
              Expanded(
                child: listBuilderTransactionList(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
