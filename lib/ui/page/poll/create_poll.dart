import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  void createPoll() async {
    final state = Provider.of<PollState>(context, listen: false);
    // validate batch name and batch description
    final isTrue = _formKey.currentState.validate();

    if (!isTrue) {
      return;
    }

    isLoading.value = true;

    final newPoll = await state.createPoll(_question.text);
    isLoading.value = false;
    if (newPoll != null) {
      Alert.sucess(context,
          message: "Poll created sucessfully!!", title: "Message");
      final homeState = Provider.of<HomeState>(context, listen: false);
      homeState.getPollList();
    } else {
      Alert.sucess(context,
          message: "Some error occured. Please try again in some time!!",
          title: "Message",
          height: 170);
      Navigator.pop(context);
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
                ),
                SizedBox(height: 10),
                _title(context, "Options"),
                SizedBox(height: 5),
                Consumer<PollState>(
                  builder: (context, state, child) {
                    return Column(
                        children: Iterable.generate(state.pollOptions.length,
                            (index) {
                      return PollOption(index: index);
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
