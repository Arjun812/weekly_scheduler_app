import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../data/database.dart';
import '../../../main.dart';
import '../../schedulePages/model/schedule_model.dart';

part 'landing_page_state.dart';

class LandingPageCubit extends Cubit<LandingPageState> {
  LandingPageCubit() : super(LandingPageInitial());

  void getDetails()async{
    Map<String,List<bool>>? freeDetails;
    emit(LandingPageLoading());
    try{
      freeDetails?.clear();
      List<Week>?  data = Hive.box<Week>(dataBoxName).values.toList();
      List<String>? text=[];
      List<bool>? busyList=[];
      bool? busy;
      for(int i =0; i<data.length;i++){
        freeDetails?.addAll({data[i].day: data[i].shift});
        String? textDay = getAvailability(day:data[i].day, getBool: data[i].shift);
        text.addAll([textDay??""]);
        busy= checkBusy(getBool: data[i].shift);
        busyList.addAll([busy!]);
      }
       busy = busyList.any((element) => element == false);
      emit(LandingPageLoaded(text,busy));
    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  bool? checkBusy({List<bool>? getBool}){
    String? morning,afterNoon,evening;
    morning = getBool![0]== true?"":"Morning,";
    afterNoon = getBool[1]== true?"":"After Noon,";
    evening = getBool[2]== true?"":"Evening";
    bool? result=false;
    if(morning == ""&& afterNoon ==""&&evening =="") {
      result = true;
    }
    return result;
  }
  String? getAvailability({List<bool>? getBool, String? day}){
    String? morning,afterNoon,evening;
    morning = getBool![0]== true?"":"Morning,";
    afterNoon = getBool[1]== true?"":"After Noon,";
    evening = getBool[2]== true?"":"Evening";
    String? result;
    if(morning != ""||afterNoon!=""||evening!="") {
      result = '${day! +" "+ morning+" " + afterNoon+" " + evening+" "}';
    }
    if(morning != ""&& afterNoon!=""&&evening!="") {
      result = 'whole ${day!}';
    }
    return result;
  }
}
