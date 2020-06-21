import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import '../screens/profile.dart';
const String testDevice="Mobile_id";

 class ShowAd extends StatefulWidget {
  @override
  _ShowAdState createState() => _ShowAdState();
 }

class _ShowAdState extends State<ShowAd> {
 static const MobileAdTargetingInfo targetingInfo=MobileAdTargetingInfo(
    testDevices: testDevice!=null? <String>[testDevice]: null,
    nonPersonalizedAds: true,
    keywords: <String>['Game','Donate','Charity'],
  );

  InterstitialAd _interstitialAd;

  

InterstitialAd createInterstitialAd(){
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event){
        print("InterstitialAd $event");
      }
    );
  }

@override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: InterstitialAd.testAdUnitId);
    createInterstitialAd()..load()..show();
    
    super.initState();
  }

  @override
  void dispose() {
    _interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:RaisedButton(
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>ProfilePage()));
          },
          child:Text("Go To Profile")
          )
      )
    );
  }
}