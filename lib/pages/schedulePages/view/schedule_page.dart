import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:weekly_scheduler_app/data/database.dart';
import 'package:weekly_scheduler_app/main.dart';
import 'package:weekly_scheduler_app/pages/schedulePages/model/schedule_model.dart';
import 'package:weekly_scheduler_app/widgets/app_bar.dart';
import 'package:weekly_scheduler_app/widgets/day_schedule_card.dart';

import '../../../utils/style/button/primary_button.dart';
import '../../../utils/style/style.dart';
import '../viewModel/schedule_page_cubit.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  void initState() {
    super.initState();
  }
  bool load=false;
  @override
  Widget build(BuildContext context) {
    bool? unavailable;

    return SafeArea(
      child: BlocProvider(
        create: (context) => SchedulePageCubit(),
        child: ValueListenableBuilder(
          valueListenable: scheduleNotifier!,
          builder:
              (BuildContext context, List<Week>? valueList, Widget? child) {
            return Scaffold(
              appBar: const WeekAppBar(
                  title: "Schedule", backgroundColor: AppColors.primaryColor),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
                child: BlocBuilder<SchedulePageCubit, SchedulePageState>(
                  builder: (context, state) {
                    if(state is SchedulePageInitial){
                      BlocProvider.of<SchedulePageCubit>(context).getWeek();
                    }
                    if (state is SchedulePageLoading) {

                      return CircularProgressIndicator();
                    }
                    if (state is SchedulePageLoaded) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Set your weekly hours',
                                style: TextStyles.subHeaderStyle,
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: state.data!.length,
                                  itemBuilder: (context, index) {
                                    unavailable = state.data![index].shift.any((element) =>
                                    element == false
                                    );
                                    return DayScheduleCard(
                                      index: index,
                                      status: unavailable ?? false,
                                      week: state.data![index],
                                    );
                                  }),
                          ],),

                          PrimaryButton(
                              height: 50,
                              width: 300,
                              text: "Save",
                              onPressed: () {
                                BlocProvider.of<SchedulePageCubit>(context).getWeek();
                                Navigator.of(context).pop();
                              })
                        ],
                      );
                    }
                    return Container();
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
