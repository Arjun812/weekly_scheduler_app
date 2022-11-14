part of 'schedule_page_cubit.dart';

abstract class SchedulePageState extends Equatable {
  const SchedulePageState();
}

class SchedulePageInitial extends SchedulePageState {
  @override
  List<Object> get props => [];


}
class SchedulePageLoading extends SchedulePageState {
  @override
  List<Object> get props => [];

}
class SchedulePageLoaded extends SchedulePageState {
  SchedulePageLoaded(this.data);

  @override
  List<Object> get props => [];
  final List<Week>? data;

}
class SchedulePageError extends SchedulePageState {
  const SchedulePageError(this.error);

  @override
  List<Object> get props => [];
final String? error;
}