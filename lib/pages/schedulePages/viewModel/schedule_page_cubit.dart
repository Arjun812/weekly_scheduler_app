import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:weekly_scheduler_app/pages/schedulePages/model/schedule_model.dart';

import '../../../data/database.dart';
import '../../../main.dart';

part 'schedule_page_state.dart';

class SchedulePageCubit extends Cubit<SchedulePageState> {
  SchedulePageCubit() : super(SchedulePageInitial());

Future<void> getWeek()async{
    emit(SchedulePageLoading());
    try{
      final box= await Hive.openBox<Week>(dataBoxName);
      scheduleNotifier!.value.clear();
      scheduleNotifier!.value.addAll(box.values);
      scheduleNotifier!.notifyListeners();
      if(scheduleNotifier!.value.length != 7){
        await addSchedule();
      }

        await getSchedule();
      // List?  data = Hive.box<Week>(dataBoxName).values.toList();
     List<Week>? data = scheduleNotifier?.value.toList();
      emit(SchedulePageLoaded(data));
    }catch(e){
      emit(SchedulePageError(e.toString()));
    }
  }
}
