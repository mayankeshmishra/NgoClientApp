import 'package:donations/helpers/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:donations/helpers/constants.dart';

Widget alarmItem(hour,context,selectedTime,selectTime,index,value,updateAlarmValue) {

  return Container(
    decoration: profilePageLoginButtonGradient,
    child: Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      selectTime(context,index);
                    },
                    child: Text(
                      hour,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SourceSansPro'),
                    ),
                  ),
                ],
              ),
              Switch(
                value: (value=="1")?true:false,
                activeTrackColor: Color(0xFF004d40),
                onChanged: (bool val) {
                  value=val?"1":"0";
                  updateAlarmValue(index,value,hour);
                  
                },
                activeColor: Color(0xff65D1BA),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        SizedBox(
          height: 1.0,
          width: double.maxFinite,
          child: Container(
            color: Colors.black,
          ),
        )
      ],
    ),
  );
}