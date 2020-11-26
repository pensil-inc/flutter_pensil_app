import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
import 'package:flutter_pensil_app/states/teacher/poll_state.dart';
import 'package:flutter_pensil_app/ui/kit/alert.dart';
import 'package:flutter_pensil_app/ui/page/poll/poll_option_widget.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/form/p_textfield.dart';
import 'package:flutter_pensil_app/ui/widget/p_button.dart';
import 'package:flutter_pensil_app/ui/widget/secondary_app_bar.dart';
import 'package:provider/provider.dart';

class CreatePoll extends StatefulWidget {
  CreatePoll({Key key}) : super(key: key);

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<PollState>(
        create: (context) => PollState(),
        child: CreatePoll(),
      ),
    );
  }

  @override
  _CreateBatchState createState() => _CreateBatchState();
}

class _CreateBatchState extends State<CreatePoll> {
  TextEditingController _description;
  TextEditingController _question;
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _description = TextEditingController();
    _question = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _question.dispose();
    _description.dispose();
    super.dispose();
  }

  Widget _secondaryButton(BuildContext context,
      {String label, Function onPressed}) {
    final theme = Theme.of(context);
    return OutlineButton.icon(
        onPressed: onPressed,
        icon: Icon(Icons.add_circle, color: PColors.primary, size: 17),
        label: Text(
          label,
          style: theme.textTheme.button
              .copyWith(color: PColors.primary, fontWeight: FontWeight.bold),
        ));
  }

  Widget _title(context, String name) {
    return Text(name,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontWeight: FontWeight.bold, fontSize: 16));
  }

  Widget _day(String text,
      {Function onPressed, Widget child, bool isStartTime}) {
    final theme = Theme.of(context);
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: AppTheme.outline(context),
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

  Future<DateTime> getDate() async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 2)),
      firstDate: DateTime.now().add(Duration(days: 1)),
      lastDate: DateTime.now().add(Duration(days: 30)),
    );
  }

  void createPoll() async {
    FocusManager.instance.primaryFocus.unfocus();
    final state = Provider.of<PollState>(context, listen: false);
    // validate batch name and batch description
    final isTrue = _formKey.currentState.validate();

    if (!isTrue) {
      return;
    }
    if (state.lastDate == null) {
      Utility.displaySnackbar(context,
          msg: "Please select poll expiry date!!", key: scaffoldKey);
      return;
    }
    if (state.lastTime == null) {
      Utility.displaySnackbar(context,
          msg: "Please select poll expiry time!!", key: scaffoldKey);
      return;
    }
    isLoading.value = true;

    final newPoll = await state.createPoll(_question.text);
    isLoading.value = false;
    if (newPoll != null) {
      // Alert.sucess(context,
      //     message: "Poll created sucessfully!!", title: "Message");
      final homeState = Provider.of<HomeState>(context, listen: false);
      homeState.getPollList();
      Navigator.pop(context);
    } else {
      Alert.sucess(context,
          message: "Some error occured. Please try again in some time!!",
          title: "Message",
          height: 170);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: CustomAppBar("Create Poll"),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                PTextField(
                  type: Type.text,
                  controller: _question,
                  label: "Poll question",
                  hintText: "Enter question",
                  maxLines: null,
                  height: null,
                ),
                SizedBox(height: 15),
                _title(context, "Poll Expire time"),
                SizedBox(height: 5),
                Container(
                    width: AppTheme.fullWidth(context) - 32,
                    height: 50,
                    child: Consumer<PollState>(
                      builder: (context, state, child) {
                        return Row(
                          children: [
                            _day(state.lastPollDate, onPressed: () async {
                              final setLastDate = await getDate();
                              if (setLastDate != null) {
                                state.setLastDate = setLastDate;
                              }
                            }).extended,
                            SizedBox(
                              width: 20,
                            ),
                            _day(state.lastPollTime, onPressed: () async {
                              final time = await getTime(context);
                              if (time != null) {
                                state.setPollExpireTime = time;
                              }
                            }).extended
                          ],
                        );
                      },
                    )),
                SizedBox(height: 15),
                _title(context, "Options"),
                SizedBox(height: 5),
                Consumer<PollState>(
                  builder: (context, state, child) {
                    return Column(
                        children: Iterable.generate(state.pollOptions.length,
                            (index) {
                      return PollOption(
                          index: index, value: state.pollOptions[index]);
                    }).toList());
                  },
                ),
                _secondaryButton(context, label: "Add option", onPressed: () {
                  Provider.of<PollState>(context, listen: false)
                      .addPollOptions();
                }),
                SizedBox(height: 150),
                PFlatButton(
                  label: "Create",
                  isLoading: isLoading,
                  onPressed: createPoll,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
