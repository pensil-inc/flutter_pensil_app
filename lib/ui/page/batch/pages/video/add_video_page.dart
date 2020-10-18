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
  final VideoState state;
  const AddVideoPage({Key key, this.subject, this.state}) : super(key: key);
  static MaterialPageRoute getRoute({String subject, String batchId, VideoState state}) {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<VideoState>(
        create: (context) => VideoState(subject: subject, batchId: batchId),
        child: AddVideoPage(subject: subject, state: state),
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

  void addLink() async {
    await Thumbnail.addLink(
      context: context,
      onLinkAdded: (mediaInfo) {
        final state = Provider.of<VideoState>(context, listen: false);
        state.setUrl(
          thumbnailUrl: mediaInfo.thumbnailUrl,
          title: mediaInfo.title,
          videoUrl: mediaInfo.url,
        );
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
      widget.state.getVideosList();
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
        appBar: CustomAppBar("Add Video"),
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
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _titleText(context, "Subject"),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 4, top: 10),
                              child: PChip(
                                label: widget.subject,
                                backgroundColor: PColors.randomColor(widget.subject),
                                borderColor: Colors.transparent,
                                style: TextStyle(color:Colors.white),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _titleText(context, "Add Link"),
                      _secondaryButton(context, label: "Add", onPressed: addLink),
                    ],
                  ).p16,
                  Consumer<VideoState>(
                    builder: (context, state, child) {
                      if (state.thumbnailUrl != null)
                        return SizedBox(
                            height: 284,
                            child: ThumbnailPreview(
                              title: state.yTitle,
                              url: state.thumbnailUrl,
                            ));
                      return SizedBox();
                    },
                  ),
                  SizedBox(height: Provider.of<VideoState>(context).videoUrl == null ? 100 : 10),
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
        ));
  }
}
