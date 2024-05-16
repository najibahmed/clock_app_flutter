

import 'package:clock_app_flutter/models/menu_info.dart';
import 'package:clock_app_flutter/constants/menu_type.dart';

import '../models/alarm_info.dart';

List<MenuInfoProvider> menuItems=[
  MenuInfoProvider(MenuType.clock,title:"Clock" ,imageSource: "assets/clock_icon.png",),
  MenuInfoProvider(MenuType.alarm,title:"Alarm" ,imageSource: 'assets/alarm_icon.png',),
  MenuInfoProvider(MenuType.timer,title:"Timer" ,imageSource: 'assets/timer_icon.png',),
  MenuInfoProvider(MenuType.stopwatch,title:"Stopwatch" ,imageSource: 'assets/stopwatch_icon.png',)
];

List<AlarmInfo> alarms = [
  AlarmInfo(alarmDateTime: DateTime.now().add(Duration(hours: 1)), title: 'Office', gradientColorIndex: 0),
  AlarmInfo(alarmDateTime: DateTime.now().add(Duration(hours: 2)), title: 'Sport', gradientColorIndex: 1),
];