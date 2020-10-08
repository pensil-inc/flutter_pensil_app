import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/batch_time_slot_model.dart';
import 'package:flutter_pensil_app/states/teacher/create_batch_state.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:provider/provider.dart';

class BatchTimeSlotWidget extends StatelessWidget {
  final BatchTimeSlotModel model;

  const BatchTimeSlotWidget({Key key, this.model}) : super(key: key);

  Widget _addClass(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: <Widget>[
        Expanded(
            child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: AppTheme.outline(context),
          child: Container(
            width: (AppTheme.fullWidth(context) / 3) - 60,
            child: DropdownButtonHideUnderline(
              child: new DropdownButton<String>(
                icon: SizedBox(
                    height: 50,
                    child: Stack(
                      overflow: Overflow.clip,
                      alignment: Alignment.center,
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 15,
                              child: Icon(Icons.arrow_drop_up, size: 30).pB(10),
                            )),
                        Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 15,
                              child:
                                  Icon(Icons.arrow_drop_down, size: 30).pT(10),
                            ))
                      ],
                    )),
                isExpanded: true,
                underline: SizedBox(),
                value: model.day,
                items: <String>[
                  'Monday',
                  'Tuesday',
                  'Wednesday',
                  'Thursday',
                  "Friday",
                  "Saturday",
                  "Sunday"
                ].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    model.day = val;
                    Provider.of<CreateBatchStates>(context, listen: false)
                        .updateTimeSlots(model);
                  }
                },
              ),
            ),
          ),
        )),
        SizedBox(width: 5),
        Expanded(
          child: _day(context, model.startTime, isStartTime: true,
              onPressed: () async {
            final time = await getTime(context);
            if (time != null) {
              model.startTime = time;
              Provider.of<CreateBatchStates>(context, listen: false)
                  .updateTimeSlots(model);
            }
          }),
        ),
        SizedBox(width: 5),
        Expanded(
          child: _day(context, model.endTime, isStartTime: false,
              onPressed: () async {
            final time = await getTime(context);
            if (time != null) {
              model.endTime = time;
              Provider.of<CreateBatchStates>(context, listen: false)
                  .updateTimeSlots(model);
            }
          }),
        ),
        SizedBox(
          height: 40,
        )
      ],
    );
  }

  Widget _day(BuildContext context, String text,
      {Function onPressed, Widget child, bool isStartTime}) {
    final theme = Theme.of(context);
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: decoration(context, isStartTime),
      child: child != null
          ? child
          : Row(
              children: <Widget>[
                Text(text),
                Spacer(),
                SizedBox(
                  height: 50,
                  child: Stack(
                    overflow: Overflow.clip,
                    alignment: Alignment.center,
                    children: <Widget>[
                      Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 15,
                            child: Icon(Icons.arrow_drop_up, size: 30).pB(10),
                          )),
                      Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 15,
                            child: Icon(Icons.arrow_drop_down, size: 30).pT(10),
                          ))
                    ],
                  ),
                ),
                SizedBox(width: 4)
              ],
            ),
    ).ripple(onPressed);
  }

  Decoration decoration(context, isStartTime) {
    if (isStartTime == null) {
      return AppTheme.outline(context);
    } else if (isStartTime) {
      return model.isValidStartEntry
          ? AppTheme.outline(context)
          : AppTheme.outlineError(context);
    } else {
      return model.isValidEndEntry
          ? AppTheme.outline(context)
          : AppTheme.outlineError(context);
    }
  }

  Future<String> getTime(BuildContext context) async {
    final time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (time == null) {
      return null;
    }
    TimeOfDay selectedTime = time;
    MaterialLocalizations localizations = MaterialLocalizations.of(context);
    String formattedTime = localizations.formatTimeOfDay(selectedTime,
        alwaysUse24HourFormat: true);
    print(formattedTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return _addClass(context);
  }
}
