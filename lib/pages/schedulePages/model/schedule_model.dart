
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:weekly_scheduler_app/data/database.dart';

import '../../../main.dart';

ValueNotifier<List<Week>>? scheduleNotifier = ValueNotifier([]);
List<String>? week = ['Week','Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
Future<void> addSchedule()async{
  Week? week1;
   List? data ;
  //List<Week>?  data = Hive.box<Week>(dataBoxName).values.toList();
  final box= await Hive.openBox<Week>(dataBoxName);
   // box.clear();

 data = box.values.toList();
  // data.clear();
  if(data.length<=6||data.length>=8){
    box.clear();
    data.clear();
    for(int i=0 ; i<week!.length ; i++){
      week1 = Week(day:week![i],shift: [false,false,false]);
      await box.addAll([week1]);
      data.addAll(box.values.toList()) ;

    }
  }

  scheduleNotifier!.value.clear();
  scheduleNotifier!.value.addAll(box.values);
}
Future<void> updateSchedule(Week week,int id)async{
  final box= await Hive.openBox<Week>(dataBoxName);
  box.putAt(id, week);
}

Future<void> getSchedule()async{
  final box= await Hive.openBox<Week>(dataBoxName);
   scheduleNotifier!.value.clear();
   scheduleNotifier!.value.addAll(box.values);
  scheduleNotifier!.notifyListeners();
}