import 'dart:developer';

import 'package:equatable/equatable.dart';

class BatchTimeSlotModel extends Equatable {
  String day;
  String startTime;
  String endTime;
  int index;
  int dayOfWeek;
  bool isValidStartEntry;
  bool isValidEndEntry;

  BatchTimeSlotModel(
      {this.day,
      this.startTime,
      this.endTime,
      this.index,
      this.dayOfWeek,
      this.isValidStartEntry = true,
      this.isValidEndEntry = true});
  factory BatchTimeSlotModel.initial() {
    return BatchTimeSlotModel(
      index: 0,
      day: "Mon",
      startTime: "Start time",
      endTime: "End time",
    );
  }
  factory BatchTimeSlotModel.fromJson(Map<String, dynamic> json) =>
      BatchTimeSlotModel(
        dayOfWeek: json["dayOfWeek"] == null ? null : json["dayOfWeek"],
        startTime: json["startTime"] == null ? null : json["startTime"],
        endTime: json["endTime"] == null ? null : json["endTime"],
      );

  Map<String, dynamic> toJson() => {
        "dayOfWeek": day == null ? dayOfWeek : toindex(),
        "startTime": startTime == null ? null : startTime.replaceAll(" ", ""),
        "endTime": endTime == null ? null : endTime.replaceAll(" ", ""),
      };
  int toindex() {
    switch (this.day) {
      case "Mon":
        return 1;
      case "Tues":
        return 2;
      case "Wed":
        return 3;
      case "Thu":
        return 4;
      case "Fri":
        return 5;
      case "Sat":
        return 6;
      case "Sun":
        return 7;

        break;
      default:
        log("Unknown Day index ${this.day}", name: "BatchTimeSlotModel");
        return 0;
    }
  }

  String toshortDay() {
    switch (this.dayOfWeek) {
      case 1:
        return "Mon";
      case 2:
        return "Tue";
      case 3:
        return "Wed";
      case 4:
        return "Thu";
      case 5:
        return "Fri";
      case 6:
        return "Sat";
      case 7:
        return "Sun";

        break;

      default:
        log("Unknown Day index ${this.dayOfWeek}",
            name: this.runtimeType.toString());
        return "N/A";
    }
  }

  @override
  List<Object> get props => [index];
}
