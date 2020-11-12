import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
import 'package:flutter_pensil_app/states/teacher/announcement_state.dart';
import 'package:flutter_pensil_app/ui/kit/alert.dart';
import 'package:flutter_pensil_app/ui/page/batch/create_batch/widget/search_batch_delegate.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/form/p_textfield.dart';
import 'package:flutter_pensil_app/ui/widget/p_button.dart';
import 'package:flutter_pensil_app/ui/widget/p_chiip.dart';
import 'package:flutter_pensil_app/ui/widget/secondary_app_bar.dart';
import 'package:provider/provider.dart';

class CreateAnnouncement extends StatefulWidget {
  CreateAnnouncement({Key key, this.selectedBatch, this.onAnnouncementCreated})
      : super(key: key);
  final BatchModel selectedBatch;
  final Function onAnnouncementCreated;
  static MaterialPageRoute getRoute(
      {BatchModel selectedBatch, Function onAnnouncementCreated}) {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<AnnouncementState>(
        create: (context) => AnnouncementState(),
        child: CreateAnnouncement(
            selectedBatch: selectedBatch,
            onAnnouncementCreated: onAnnouncementCreated),
      ),
    );
  }

  @override
  _CreateBatchState createState() => _CreateBatchState();
}

class _CreateBatchState extends State<CreateAnnouncement> {
  TextEditingController _description;
  TextEditingController _title;
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  ValueNotifier<List<BatchModel>> batchList =
      ValueNotifier<List<BatchModel>>([]);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _description = TextEditingController();
    _title = TextEditingController();
    if (widget.selectedBatch != null) batchList.value = [widget.selectedBatch];
    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    batchList.dispose();
    _description.dispose();
    super.dispose();
  }

  Widget _titleText(context, String name) {
    return Text(name,
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontWeight: FontWeight.bold, fontSize: 16));
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

  void displayBatchList() async {
    final list = Provider.of<HomeState>(context, listen: false).batchList;
    if (!(list != null && list.isNotEmpty)) {
      return;
    }
    print(list.length);
    await showSearch(
        context: context,
        delegate: BatchSearch(
            list, Provider.of<HomeState>(context, listen: false), batchList));
  }

  void createAnnouncement() async {
    final state = Provider.of<AnnouncementState>(context, listen: false);
    // validate batch name and batch description
    final isTrue = _formKey.currentState.validate();

    if (!isTrue) {
      return;
    }

    isLoading.value = true;

    final addNewAnnouncment = await state.createAnnouncement(
        title: _title.text,
        description: _description.text,
        batches: batchList.value);
    isLoading.value = false;
    if (addNewAnnouncment != null) {
      Alert.sucess(context,
          message: "Announcement created sucessfully!!", title: "Message");
      if (widget.onAnnouncementCreated != null) {
        widget.onAnnouncementCreated();
      }
      final homeState = Provider.of<HomeState>(context, listen: false);
      homeState.getAnnouncemantList();
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
      appBar: CustomAppBar("Create Announcement"),
      body: Container(
        padding: EdgeInsets.only(left: 16, right: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 16),
                // PTextField(
                //   type: Type.text,
                //   controller: _title,
                //   label: "Title",
                //   hintText: "Enter title here",
                // ),
                PTextField(
                    type: Type.text,
                    controller: _description,
                    label: "Description",
                    hintText: "Enter here",
                    maxLines: null,
                    height: null,
                    padding: EdgeInsets.symmetric(vertical: 16)),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _titleText(context, "Add Batch"),
                    _secondaryButton(context,
                        label: "Pick Batch", onPressed: displayBatchList),
                  ],
                ),
                if (batchList != null)
                  ValueListenableBuilder<List<BatchModel>>(
                      valueListenable: batchList,
                      builder: (context, listenableList, chils) {
                        return Wrap(
                            children: listenableList
                                .where((element) => element.isSelected)
                                .map((e) => Padding(
                                    padding: EdgeInsets.only(right: 4, top: 4),
                                    child: PChip(label: e.name)))
                                .toList());
                      }),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("For all batches",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Switch(
                      value: Provider.of<AnnouncementState>(
                        context,
                      ).isForAll,
                      onChanged: Provider.of<AnnouncementState>(
                        context,
                      ).setIsForAll,
                    ),
                  ],
                ),
                SizedBox(height: 150),
                PFlatButton(
                  label: "Create",
                  isLoading: isLoading,
                  onPressed: createAnnouncement,
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
