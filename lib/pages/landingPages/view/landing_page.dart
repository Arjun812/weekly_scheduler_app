import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weekly_scheduler_app/pages/landingPages/viewModel/landing_page_cubit.dart';
import 'package:weekly_scheduler_app/utils/style/button/primary_button.dart';

import '../../../utils/constants.dart';
import '../../../utils/style/style.dart';
import '../../schedulePages/model/schedule_model.dart';
import '../../schedulePages/viewModel/schedule_page_cubit.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      LandingPageCubit()
        ..getDetails(),
      child: SafeArea(
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocBuilder<LandingPageCubit, LandingPageState>(
                builder: (context, state) {
                  if(state is LandingPageLoading){
                    return const Center(child: CircularProgressIndicator());
                  }
                  if(state is LandingPageLoaded){
                    List<String>? text = state.data;
                    String? convertedText = text!.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(', ,', '').replaceAll(' ,', '');
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: SizedBox(
                              //height: 150,
                              width: double.infinity,
                              child: Center(
                                heightFactor: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      state.busy == true? greeting+availableIn+convertedText:
                                    '$greeting you are busy this week',
                                      maxLines: 10,
                                      style: TextStyles.subHeaderStyle,
                                      textAlign: TextAlign.justify,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ))),
                        ),
                        PrimaryButton(
                            height: 50,
                            width: 300,
                            text: state.busy == true?"Edit Schedule":"Add Schedule",
                            onPressed: () {
                              Navigator.of(context).pushNamed('schedule').then((value) => BlocProvider.of<LandingPageCubit>(context)..getDetails());
                            })
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          )),
    );
  }
}
