

import 'package:hive/hive.dart';
part 'database.g.dart';

@HiveType(typeId: 2)
class Week {
  Week({required this.day, required this.shift,this.id});

  @HiveField(0)
 final int? id;

  @HiveField(1)
 final String day;

  @HiveField(2)
 final List<bool> shift;

  // @override
  // String toString() {
  //   return '$id''$day: $shift';
  // }
}
