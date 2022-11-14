import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:weekly_scheduler_app/data/arguments.dart';
import 'package:weekly_scheduler_app/pages/schedulePages/viewModel/schedule_page_cubit.dart';
import 'package:weekly_scheduler_app/widgets/shift_button.dart';

import '../data/database.dart';
import '../main.dart';
import '../pages/schedulePages/model/schedule_model.dart';
import '../utils/style/style.dart';

class DayScheduleCard extends StatefulWidget {
  const DayScheduleCard({Key? key, this.week, this.index, this.status})
      : super(key: key);
  final Week? week;
  final int? index;
  final bool? status;

  @override
  State<DayScheduleCard> createState() => _DayScheduleCardState();
}

class _DayScheduleCardState extends State<DayScheduleCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
           GestureDetector(
               onTap: ()async{
                 final box = await Hive.openBox<Week>(dataBoxName);
                 box.putAt(
                     widget.index!,
                     Week(day: widget.week!.day, shift: [
                       false,
                       false,
                       false
                     ]));
                 BlocProvider.of<SchedulePageCubit>(context).getWeek();
               },
               child: Icon(Icons.check_circle,color: widget.status == true?Colors.green:Colors.grey,)),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
              width: 40,
              child: Text(
                widget.week?.day ?? "day",
                style: TextStyles.subHeaderStyle,
              )),
          const SizedBox(
            width: 10,
          ),
          widget.status == true
              ? Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        print("morning touche");
                        bool? _current;
                        widget.week!.shift[0] == true
                            ? _current = false
                            : _current = true;
                        final box = await Hive.openBox<Week>(dataBoxName);
                        box.putAt(
                            widget.index!,
                            Week(day: widget.week!.day, shift: [
                              _current,
                              widget.week!.shift[1],
                              widget.week!.shift[2]
                            ]));
                        BlocProvider.of<SchedulePageCubit>(context).getWeek();
                        // box.delete(widget.week!.day,);
                      },
                      child: AbsorbPointer(
                        child: ShiftButton(
                          shiftName: "Morning",
                          status: widget.week?.shift[0],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        print("Noon touche");
                        bool? _current;
                        widget.week!.shift[1] == true
                            ? _current = false
                            : _current = true;
                        final box = await Hive.openBox<Week>(dataBoxName);
                        box.putAt(
                            widget.index!,
                            Week(day: widget.week!.day, shift: [
                              widget.week!.shift[0],
                              _current,
                              widget.week!.shift[2]
                            ]));
                        BlocProvider.of<SchedulePageCubit>(context).getWeek();
                      },
                      child: AbsorbPointer(
                        child: ShiftButton(
                          shiftName: "Afternoon",
                          status: widget.week?.shift[1],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        print("Noon touche");
                        bool? _current;
                        widget.week!.shift[2] == true
                            ? _current = false
                            : _current = true;
                        final box = await Hive.openBox<Week>(dataBoxName);
                        box.putAt(
                            widget.index!,
                            Week(day: widget.week!.day, shift: [
                              widget.week!.shift[0],
                              widget.week!.shift[1],
                              _current
                            ]));
                        BlocProvider.of<SchedulePageCubit>(context).getWeek();
                      },
                      child: AbsorbPointer(
                        child: ShiftButton(
                          shiftName: "Evening",
                          status: widget.week?.shift[2],
                        ),
                      ),
                    ),
                  ],
                )
              : const Text('Unavailable'),
        ],
      ),
    );
  }
}
