import 'package:donations/screens/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsDelayed {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final context;
  final time;
  DateTime schedule;
  final int index;

  LocalNotificationsDelayed({this.context, this.time, this.index}) {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);

    DateTime today = new DateTime.now();
    String hour = time.substring(0, time.indexOf(':'));
    String minutes = time.substring(time.indexOf(':') + 1, time.indexOf(' '));
    String ampm = time.substring(time.indexOf(' ') + 1);

    if (ampm == "PM") {
      hour = (int.parse(hour) < 12 ? int.parse(hour) + 12 : int.parse(hour))
          .toString();
          
    }
    else{
       hour = (int.parse(hour) >= 12 ? int.parse(hour) - 12 : int.parse(hour))
          .toString();
          if(hour.length==1){
            hour="0"+hour;
          }
    }
    String newTime =
        today.toString().substring(0, today.toString().indexOf(' ')) +
            " " +
            hour +
            ":" +
            minutes +
            ":00";
    DateTime myDatetime = DateTime.parse(newTime);
    schedule = myDatetime
        .subtract(new Duration(hours: today.hour, minutes: today.minute));
  }
  void cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(index);
  }

  Future onSelectNotification(String payload) {
    
  }

  showNotification() async {
    print(index);
    print("hours:"+schedule.hour.toString());
    print("minutes:"+schedule.minute.toString());
    var android = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description');
    var iOS = IOSNotificationDetails();
    var platform = NotificationDetails(android, iOS);
    var scheduledNotificationDateTime =
        new DateTime.now().add(Duration(hours:schedule.hour,minutes:schedule.minute,seconds: 00));
    await flutterLocalNotificationsPlugin.schedule(
        index, 'Hi There', 'You have set up a notification to donate!! Hurry up, people need you', scheduledNotificationDateTime, platform);
  }
}
