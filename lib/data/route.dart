import 'package:flutter/material.dart';
import 'package:weekly_scheduler_app/pages/landingPages/view/landing_page.dart';
import 'package:weekly_scheduler_app/pages/schedulePages/view/schedule_page.dart';

class Routes {


  static const String landing = 'landing';
  static const String schedule = 'schedule';

  Map<String, WidgetBuilder> routeBuilders(BuildContext context) {
    return {
      landing: (context) => const LandingPage(),
      schedule: (context) => const SchedulePage(),
    };
  }
}