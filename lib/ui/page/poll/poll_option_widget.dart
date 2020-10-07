import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/states/teacher/poll_state.dart';
import 'package:flutter_pensil_app/ui/widget/form/p_textfield.dart';
import 'package:provider/provider.dart';

class PollOption extends StatefulWidget {
  const PollOption({Key key, this.index}) : super(key: key);
  final int index;

  @override
  _PollOptionState createState() => _PollOptionState();
}

class _PollOptionState extends State<PollOption> {
  TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController()
      ..addListener(() {
        Provider.of<PollState>(context, listen: false)
            .addValueToPollOption(controller.text, widget.index);
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PTextField(
      type: Type.text,
      controller: controller,
      hintText: "Enter option ${widget.index}",
    );
  }
}
