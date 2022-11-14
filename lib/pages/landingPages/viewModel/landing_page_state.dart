part of 'landing_page_cubit.dart';

@immutable
abstract class LandingPageState {}

class LandingPageInitial extends LandingPageState {}

class LandingPageLoading extends LandingPageState {}

class LandingPageLoaded extends LandingPageState {
 final List<String>? data;
 final bool? busy;

  LandingPageLoaded(this.data, this.busy);
}
