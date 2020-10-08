import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/states/teacher/create_batch_state.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/p_chiip.dart';
import 'package:provider/provider.dart';

class AddStudentsWidget extends StatelessWidget {
  const AddStudentsWidget({Key key, this.controller}) : super(key: key);
  final TextEditingController controller;
  Widget _enterContactNo(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          border: InputBorder.none, hintText: "Enter contact no.."),
      onSubmitted: (contact) {
        Provider.of<CreateBatchStates>(context, listen: false).addContact(contact);
        controller.clear();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 8),
      width: AppTheme.fullWidth(context),
      decoration: AppTheme.outline(context),
      child: Consumer<CreateBatchStates>(
        builder: (context, state, child) {
          return Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: !(state.contactList != null &&
                      state.contactList.isNotEmpty)
                  ? <Widget>[SizedBox.shrink()]
                  : state.contactList
                      .map((e) => PChip(
                            label: e,
                            onDeleted: () {
                              Provider.of<CreateBatchStates>(context, listen: false)
                                  .removeContact(e);
                            },
                          ).p(3))
                      .toList()
                ..add(
                    SizedBox(width: 120, child: _enterContactNo(context)).hP8));
        },
      ),
    );
  }
}
