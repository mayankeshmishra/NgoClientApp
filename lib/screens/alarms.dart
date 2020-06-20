import 'package:donations/helpers/constants.dart';

import 'package:donations/helpers/notifications_delayed.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:donations/helpers/alarmitem.dart';
import '../helpers/constants.dart';
import '../ui_components/bottom_app_bar.dart';

class Alarm extends StatefulWidget {
  final List<String> storedAlarms;
  final List<String> storedAlarmValues;
  Alarm({this.storedAlarms, this.storedAlarmValues});
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  TimeOfDay _selectedTime;
  ValueChanged<TimeOfDay> selectTime;
  List<String> alarms = [];
  List<String> alarmValues = [];

  void initState() {
    super.initState();
    _selectedTime = new TimeOfDay(hour: 12, minute: 30);
    alarms = widget.storedAlarms;
    alarmValues = widget.storedAlarmValues;
  }

  Future<void> _storeAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('storedAlarms', alarms);
    await prefs.setStringList('storedAlarmsValues', alarmValues);
  }

  void addAlarm(picked, context) {
    alarms.add(picked);
    alarmValues.add("0");
    _storeAlarms();
  }

  void updateAlarm(index, value) {
    alarms[index] = value;
    alarmValues[index]="0";

    _storeAlarms();
  }

  void updateAlarmValue(index, value, time) {
    setState(() {
      alarmValues[index] = value;
      LocalNotificationsDelayed notification =
          LocalNotificationsDelayed(context: context,time: time,index:index);
      if (value == "1") {
        notification.showNotification();
      } else {
        notification.cancelNotification();
      }
      _storeAlarms();
    });
  }

  Widget listBuilder(BuildContext context) {
    return ListView.builder(
        itemCount: alarms.length,
        itemBuilder: (BuildContext context, int i) {
          return Dismissible(
            key: Key(alarms[i]),
            child: alarmItem(alarms[i], context, _selectedTime, _selectTime, i,
                alarmValues[i], updateAlarmValue),
            onDismissed: (direction) {
              setState(() {
                try {
                  alarms.removeAt(i);
                  alarmValues.removeAt(i);
                } catch (e) {}
                _storeAlarms();
              });
            },
          );
        });
  }

  Future<void> _selectTime(BuildContext context, key) async {
    @override
    final TimeOfDay picked =
        await showTimePicker(context: context, initialTime: _selectedTime);
    setState(() {
      if (picked != null) {
        _selectedTime = picked;
        if (key == -1) {
          addAlarm(picked.format(context), context);
        } else {
          updateAlarm(key, picked.format(context));
        }
      }
    });
  }
  BottomAppBarClass appBar = BottomAppBarClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: appBar.getAppBar(context: context),
      
      body: Container(
          decoration: profilePageLoginButtonGradient,
          child: listBuilder(context)),
      floatingActionButton: _bottomButtons(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _bottomButtons(context) {
    return FloatingActionButton(
      onPressed: () {
        _selectTime(context, -1);
      },
      backgroundColor: Color(0xff65D1BA),
      child: Icon(
        Icons.add,
        size: 20.0,
      ),
    );
  }
}
