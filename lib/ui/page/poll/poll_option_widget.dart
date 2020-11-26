import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/states/teacher/poll_state.dart';
import 'package:flutter_pensil_app/ui/widget/form/p_textfield.dart';
import 'package:provider/provider.dart';

class PollOption extends StatefulWidget {
  const PollOption({Key key, this.index, this.value}) : super(key: key);
  final int index;
  final String value;

  @override
  _PollOptionState createState() => _PollOptionState();
}

class _PollOptionState extends State<PollOption> {
  TextEditingController controller;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value)
      ..addListener(writeData);
  }

  @override
  void didUpdateWidget(PollOption oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        controller.text = widget.value;
      });
    }
  }

  void writeData() {
    Provider.of<PollState>(context, listen: false)
        .addValueToPollOption(controller.text, widget.index);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: PTextField(
        type: Type.text,
        controller: controller,
        hintText: "Enter option ${widget.index}",
        maxLines: null,
        height: null,
        suffixIcon: widget.index < 2
            ? null
            : IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  controller.removeListener(writeData);
                  Provider.of<PollState>(context, listen: false)
                      .removePollOption(widget.index);
                },
              ),
      ),
    );
  }
}
