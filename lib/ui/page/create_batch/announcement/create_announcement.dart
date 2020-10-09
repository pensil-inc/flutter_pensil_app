import 'package:filter_list/filter_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/states/home_state.dart';
import 'package:flutter_pensil_app/states/teacher/announcement_state.dart';
import 'package:flutter_pensil_app/ui/kit/alert.dart';
import 'package:flutter_pensil_app/ui/widget/form/p_textfield.dart';
import 'package:flutter_pensil_app/ui/widget/p_button.dart';
import 'package:flutter_pensil_app/ui/widget/secondary_app_bar.dart';
import 'package:provider/provider.dart';

class CreateAnnouncement extends StatefulWidget {
  CreateAnnouncement({Key key}) : super(key: key);

  static MaterialPageRoute getRoute() {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<AnnouncementState>(
        create: (context) => AnnouncementState(),
        child: CreateAnnouncement(),
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
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    _description = TextEditingController();
    _title = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
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
        title: _title.text, description: _description.text);
    isLoading.value = false;
    if (addNewAnnouncment != null) {
      Alert.sucess(context,
          message: "Announcement created sucessfully!!", title: "Message");
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
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                 PTextField(
                    type: Type.text,
                    controller: _title,
                    label: "Title",
                    hintText: "Enter title here",),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
