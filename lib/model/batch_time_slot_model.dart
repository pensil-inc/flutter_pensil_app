import 'package:equatable/equatable.dart';

class BatchTimeSlotModel extends Equatable{
  String day;
  String startTime;
  String endTime;
  int index;
  int dayOfWeek;
  bool isValidStartEntry;
  bool isValidEndEntry;

  BatchTimeSlotModel({this.day, this.startTime, this.endTime, this.index,this.dayOfWeek,this.isValidStartEntry = true, this.isValidEndEntry = true});
  factory BatchTimeSlotModel.initial(){
    return BatchTimeSlotModel(
      index:0,
      day: "Monday",
      startTime: "Start time",
      endTime: "End time",
    );
  }
   factory BatchTimeSlotModel.fromJson(Map<String, dynamic> json) => BatchTimeSlotModel(
        dayOfWeek: json["dayOfWeek"] == null ? null : json["dayOfWeek"],
        startTime: json["startTime"] == null ? null : json["startTime"],
        endTime: json["endTime"] == null ? null : json["endTime"],
    );

    Map<String, dynamic> toJson() => {
        "dayOfWeek": day == null ? null : toindex(),
        "startTime": startTime == null ? null : startTime.replaceAll(" ", ""),
        "endTime": endTime == null ? null : endTime.replaceAll(" ", ""),
    };
   int toindex(){
      switch (this.day) {
        case "Monday": return 1;
        case "Tuesday": return 2;
        case "Wednesday": return 3;
        case "Thursday": return 4;
        case "Friday": return 5;
        case "Saturday": return 6;
        case "Sunday": return 7;
          
          break;
        default: return 0;
      }
    }
  @override
  List<Object> get props => [index];
}