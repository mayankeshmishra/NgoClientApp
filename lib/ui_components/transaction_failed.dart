import 'package:flutter/material.dart';

import 'package:donations/helpers/constants.dart';

class TransactionFailedPage extends StatelessWidget {
  final String message;
  final String code;
  TransactionFailedPage({this.message,this.code});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/transactionfailed.jpg"), fit: BoxFit.cover)),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.8,
              ),
              Center(
                child: Text(
                  "Payment Failed",
                  style: TextStyle(
                      fontSize: 30,
                      color: Color(0xFFff1744),
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("Error Message :",
                      style: TextStyle(fontSize: 20, color: Color(0xFF00695c))),
                  Text(message,
                      style: TextStyle(fontSize: 15, color: Color(0xFFff1744))),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Unfortunately some error occurred",
                style: TextStyle(color: Color(0xFF757575), fontSize: 18),
              ),
              Text(
                "Your Donation will surely make a big Difference",
                style: TextStyle(color: Color(0xFF757575)),
              ),
              Text(
                "Keep Donating Keep Helping",
                style: TextStyle(color: Color(0xFF00e676)),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {Navigator.pop(context);},
                child: Container(
                    decoration: profilePageLoginButtonGradient,
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    child: ListTile(
                      title: Center(
                        child: Text(
                          "TRY AGAIN",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
