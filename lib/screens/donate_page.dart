import 'package:donations/ui_components/ngo_list_card.dart';
import 'package:donations/ui_components/transaction_success.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/services.dart';

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

  List<String> ngoList=['Child NGO','Animal NGO', 'Educational NGO', 'Enviorment NGO', 'Child NGO', 'Child NGO', 'Child NGO'];
  List<String> categoryList=['Child','Animal','Educational','Enviorment'];
  List<String> categoryimage=['child.jpg','dog.jpg','educate.jpg','enviorment.jpg'];

  void initState() {
    super.initState();
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

  void openCheckout(ngoName) async {
    print("reached");
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': amount*100,
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
    Navigator.push(context, MaterialPageRoute(builder: (context)=>TransactionPage(transactionId:response.paymentId)));
    
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>TransactionFailedPage(message:response.message,code:response.code.toString())));
    // Fluttertoast.showToast(
    //     msg: "ERROR: " + response.code.toString() + " - " + response.message,);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Fluttertoast.showToast(
    //     msg: "EXTERNAL_WALLET: " + response.walletName,);
  }


  
  Widget listBuilderCategory(BuildContext context,deviceHeight, deviceWidth) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
            child:  card.getCard(
                              deviceHeight: deviceHeight,
                              deviceWidth: deviceWidth,
                              imagename: categoryimage[i],
                              type: categoryList[i],
                              ),
            onTap: (){showPaymentAlert(context,ngoList[i]);}
          );
        });
  }
  
  Widget listBuilderNGOList(BuildContext context) {
    return ListView.builder(
        itemCount: ngoList.length,
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
            child:  ngoCard.getCard(ngoList[i]),
            onTap: (){showPaymentAlert(context,ngoList[i]);}
          );
        });
  }

  showPaymentAlert(context,ngoName){
    Alert(
        context: context,
        title:ngoName,
        style: AlertStyle(
          titleStyle:TextStyle(color: Color(0xFF004d40), fontSize: 25),
        ),
        content: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.favorite,color: Color(0xFFf50057),),
                labelText: 'Enter Amount',
                
              ),
              keyboardType: TextInputType.number,
              onChanged:(value){
                setState(() {
                  amount= double.parse(value);
                });
              }
            ),
            
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => openCheckout(ngoName),
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
                      child:listBuilderCategory(context, deviceHeight, deviceWidth)
                    ),
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
