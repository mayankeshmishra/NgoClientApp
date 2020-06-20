import 'package:donations/screens/donate_page.dart';
import 'package:donations/screens/profile.dart';
import 'package:donations/screens/transactions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:donations/screens/alarms.dart';
import '../home.dart';

class BottomAppBarClass{
  List<String>storedAlarms;
  List<String>storedAlarmValues;
    _getList() async {
    final prefs = await SharedPreferences.getInstance();
    storedAlarms = prefs.getStringList('storedAlarms')??[];
    storedAlarmValues = prefs.getStringList('storedAlarmsValues')??[];
    return storedAlarms;
  }

  Widget getAppBar({context}){
    return BottomAppBar(
        color: Colors.transparent,
        child: Container(
          color: Colors.white,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)  => DonatePage(),
                    ),
                  );
                },
                child: Icon(
                IconData(0xe800, fontFamily: 'Donate'),
                color: Color(0xFF00695c),
              ),
              ),
              GestureDetector(
                onTap: () async {
                  storedAlarms=await _getList();
                  print(storedAlarms);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)  => Alarm(storedAlarms:storedAlarms,storedAlarmValues: storedAlarmValues,),
                    ),
                  );
                },
                child: Icon(
                  Icons.add_alarm,
                  color: Color(0xFF00695c),
                ),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)  => HomePage(),
                    ),
                  );
                },
                child: Icon(
                  Icons.home,
                  color: Color(0xFF00695c),
                ),
              ),
              GestureDetector(
                onTap: (){
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)  => Transactions(),
                    ),
                  );
                },
                child:Icon(
                Icons.format_list_bulleted,
                color: Color(0xFF00695c),
              ),
              ),
              
              GestureDetector(
                onTap: (){
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)  => ProfilePage(),
                    ),
                  );
                },
                child: Icon(
                  Icons.account_circle,
                  color: Color(0xFF00695c),
                ),
              ),
            ],
          ),
        ),
      );
  }
}