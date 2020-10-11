import 'package:add_thumbnail/add_thumbnail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/states/teacher/announcement_state.dart';
import 'package:flutter_pensil_app/states/teacher/video/video_state.dart';
import 'package:flutter_pensil_app/ui/kit/alert.dart';
import 'package:flutter_pensil_app/ui/page/batch/pages/video/video_preview.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/form/p_textfield.dart';
import 'package:flutter_pensil_app/ui/widget/p_button.dart';
import 'package:flutter_pensil_app/ui/widget/p_chiip.dart';
import 'package:flutter_pensil_app/ui/widget/secondary_app_bar.dart';
import 'package:provider/provider.dart';

class AddVideoPage extends StatefulWidget {
  final String subject;
  const AddVideoPage({Key key, this.subject}) : super(key: key);
  static MaterialPageRoute getRoute(String subject) {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<VideoState>(
        create: (context) => VideoState(),
        child: AddVideoPage(subject: subject),
      ),
    );
  }

  @override
  _AddVideoPageState createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  TextEditingController _description;
  TextEditingController _title;
  final _formKey = GlobalKey<FormState>();
  ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);
  ValueNotifier<List<BatchModel>> batchList = ValueNotifier<List<BatchModel>>([]);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> urlList = ["https://www.youtube.com/watch?v=uv54ec8Pg1k"];
  @override
  void initState() {
    _description = TextEditingController();
    _title = TextEditingController();
    // batchList.value = Provider.of<HomeState>(context).batchList;
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
    return Text(name, style: Theme.of(context).textTheme.bodyText1.copyWith(fontWeight: FontWeight.bold, fontSize: 16));
  }

  Widget _secondaryButton(BuildContext context, {String label, Function onPressed}) {
    final theme = Theme.of(context);
    return OutlineButton.icon(
        onPressed: onPressed,
        icon: Icon(Icons.add_circle, color: PColors.primary, size: 17),
        label: Text(
          label,
          style: theme.textTheme.button.copyWith(color: PColors.primary, fontWeight: FontWeight.bold),
        ));
  }

  void displayBatchList() async {
    // final list = Provider.of<HomeState>(context, listen: false).batchList;
    // if (!(list != null && list.isNotEmpty)) {
    //   return;
    // }
    // print(list.length);
    // await showSearch(
    //     context: context,
    //     delegate: BatchSearch(
    //         list, Provider.of<HomeState>(context, listen: false), batchList));
  }
  void addLink() async {
    await Thumbnail.addLink(
      context: context,
      onLinkAdded: (mediaInfo) {
        final state = Provider.of<VideoState>(context, listen: false);
        state.setUrl(mediaInfo.thumbnailUrl, mediaInfo.title);
      },
    );
  }

  void saveVideo() async {
    final state = Provider.of<VideoState>(context, listen: false);
    // validate batch name and batch description
    final isTrue = _formKey.currentState.validate();

    if (!isTrue) {
      return;
    }

    isLoading.value = true;

    final isOk = await state.addVideo(_title.text, _description.text);
    isLoading.value = false;
    if (isOk != null) {
      Alert.sucess(context, message: "Video added sucessfully!!", title: "Message");
      // final homeState = Provider.of<HomeState>(context, listen: false);
      // homeState.getAnnouncemantList();
    } else {
      Alert.sucess(context, message: "Some error occured. Please try again in some time!!", title: "Message", height: 170);
      // Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xffeeeeee),
      appBar: CustomAppBar("Create Announcement"),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    color: Color(0xfffafafa),
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 16),
                        PTextField(
                          type: Type.text,
                          controller: _title,
                          label: "Title",
                          hintText: "Enter title here",
                        ),
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
                            _titleText(context, "Add Subject"),
                            _secondaryButton(context, label: "Pick Subject", onPressed: displayBatchList),
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
                                              child: PChip(label: e.name),
                                            ))
                                        .toList());
                              }),
                        SizedBox(height: 20),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _titleText(context, "Add Link"),
                    _secondaryButton(context, label: "Add", onPressed: addLink),
                  ],
                ).p16,
                Consumer<VideoState>(
                  builder: (context, state, child) {
                    if (state.yUrl != null)
                      return SizedBox(
                          height: 284,
                          child: ThumbnailPreview(
                            title: state.yTitle,
                            url: state.yUrl,
                          ));
                    return SizedBox();
                  },
                ),
                SizedBox(height: Provider.of<VideoState>(context).yUrl == null ? 100 : 10),
                PFlatButton(
                  label: "Create",
                  isLoading: isLoading,
                  onPressed: saveVideo,
                ).p16,
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
