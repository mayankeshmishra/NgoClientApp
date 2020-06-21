import 'package:donations/ui_components/ngo_list_card.dart';
import 'package:donations/ui_components/transaction_success.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/services.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:donations/helpers/constants.dart';
import '../ui_components/bottom_app_bar.dart';
import 'package:donations/helpers/clip_path.dart';
import '../ui_components/make_category_card.dart';
import '../ui_components/ngo_list_card.dart';
import '../ui_components/transaction_failed.dart';

class DonatePage extends StatefulWidget {
  @override
  _DonatePageState createState() => _DonatePageState();
}

class _DonatePageState extends State<DonatePage> {
  ClipPathClass clip = ClipPathClass();
  BottomAppBarClass appBar = BottomAppBarClass();
  MakeCard card = MakeCard();
  NgoCard ngoCard = NgoCard();
  Razorpay _razorpay;
  double amount;

  static const platform = const MethodChannel("razorpay_flutter");

  List<String> ngoList = [];
  List<String> ngoApiKeys = [];
  List<String> categoryList = ['Child', 'Animal', 'Educational', 'Enviorment'];
  List<String> categoryimage = [
    'child.jpg',
    'dog.jpg',
    'educate.jpg',
    'enviorment.jpg'
  ];

  void initState() {
    super.initState();

    DatabaseReference postsRef =
        FirebaseDatabase.instance.reference().child("NGO");
    postsRef.once().then((DataSnapshot snap) {
      var KEYS = snap.value.keys;
      var DATA = snap.value;

      ngoList.clear();
      ngoApiKeys.clear();

      for (var indivisualKey in KEYS) {
        ngoList.add(DATA[indivisualKey]['name']);
        ngoApiKeys.add(DATA[indivisualKey]['apiKey']);
      }
      setState(() {
        print('Length:$ngoList.length');
      });
    });

    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout(ngoName,ngoApiKey) async {
    print("reached");
    var options = {
      'key': ngoApiKey,
      'amount': amount * 100,
      'name': ngoName,
      'description': 'Fine T-Shirt',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TransactionPage(transactionId: response.paymentId)));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TransactionFailedPage(
                message: response.message, code: response.code.toString())));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  Widget listBuilderCategory(BuildContext context, deviceHeight, deviceWidth) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
              child: card.getCard(
                deviceHeight: deviceHeight,
                deviceWidth: deviceWidth,
                imagename: categoryimage[i],
                type: categoryList[i],
              ),
              onTap: () {
                
              });
        });
  }

  Widget listBuilderNGOList(BuildContext context) {
    return ListView.builder(
        itemCount: ngoList.length,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
              child: ngoCard.getCard(ngoList[i]),
              onTap: () {
                showPaymentAlert(context, ngoList[i],ngoApiKeys[i]);
              });
        });
  }

  showPaymentAlert(context, ngoName, ngoApiKey) {
    Alert(
        context: context,
        title: ngoName,
        style: AlertStyle(
          titleStyle: TextStyle(color: Color(0xFF004d40), fontSize: 25),
        ),
        content: Column(
          children: <Widget>[
            TextField(
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.favorite,
                    color: Color(0xFFf50057),
                  ),
                  labelText: 'Enter Amount',
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    amount = double.parse(value);
                  });
                }),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => openCheckout(ngoName,ngoApiKeys),
            color: Color(0xFF00695c),
            child: Text(
              "Make Payment",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: appBar.getAppBar(context: context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          width: deviceWidth,
          decoration: gradient,
          child: Column(
            children: <Widget>[
              Container(
                height: deviceHeight / 3,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Row(
                      children: <Widget>[
                        Text(
                          "Explore",
                          style: profilePageDonationTextHeadingStyle,
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          "Categories",
                          style:
                              TextStyle(fontSize: 30, color: Color(0xFF4db6ac)),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Expanded(
                        child: listBuilderCategory(
                            context, deviceHeight, deviceWidth)),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: listBuilderNGOList(context),
              )
            ],
          ),
        ),
      ),
    );
  }
}
