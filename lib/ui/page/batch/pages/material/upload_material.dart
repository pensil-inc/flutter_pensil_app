import 'dart:io';

import 'package:add_thumbnail/add_thumbnail.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/images.dart';
import 'package:flutter_pensil_app/model/batch_model.dart';
import 'package:flutter_pensil_app/states/teacher/material/batch_material_state.dart';
import 'package:flutter_pensil_app/ui/kit/alert.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';
import 'package:flutter_pensil_app/ui/widget/form/p_textfield.dart';
import 'package:flutter_pensil_app/ui/widget/p_button.dart';
import 'package:flutter_pensil_app/ui/widget/p_chiip.dart';
import 'package:flutter_pensil_app/ui/widget/secondary_app_bar.dart';
import 'package:provider/provider.dart';

class UploadMaterialPage extends StatefulWidget {
  final String subject;
  const UploadMaterialPage({Key key, this.subject}) : super(key: key);
  static MaterialPageRoute getRoute(String subject) {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider<BatchMaterialState>(
        create: (context) => BatchMaterialState(),
        child: UploadMaterialPage(subject: subject),
      ),
    );
  }

  @override
  _UploadMaterialPageState createState() => _UploadMaterialPageState();
}

class _UploadMaterialPageState extends State<UploadMaterialPage> {
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
        final state = Provider.of<BatchMaterialState>(context, listen: false);
        state.setArticleUrl(mediaInfo.thumbnailUrl, mediaInfo.title);
      },
    );
  }

  void pickFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'pdf', 'doc'],
    );
    if (result != null) {
      PlatformFile file = result.files.first;
      final state = Provider.of<BatchMaterialState>(context, listen: false);
      state.setFile = File(file.path);
    }
  }

  void saveVideo() async {
    final state = Provider.of<BatchMaterialState>(context, listen: false);
    // validate batch name and batch description
    final isTrue = _formKey.currentState.validate();

    if (!isTrue) {
      return;
    }

    isLoading.value = true;

    final isOk = await state.addMaterial(_title.text, _description.text);
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
      appBar: CustomAppBar("Upload Material"),
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                              child: PChip(label: widget.subject, backgroundColor: PColors.yellow, borderColor: Colors.transparent),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                      ],
                    )),
                _titleText(context, "Add Link").vP16,
                PTextField(
                  type: Type.text,
                  controller: _title,
                  // label: "Title",
                  hintText: "Paste link here",
                  onSubmit: (val) {
                    print(val);
                  },
                ).hP16,

                // SizedBox(height: 10),
                Center(child: _titleText(context, "OR")),
                SizedBox(height: 10),
                Center(child: _titleText(context, "Upload File")),
                SizedBox(height: 10),
                Container(
                  width: AppTheme.fullWidth(context) - 32,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: AppTheme.outline(context),
                  child: Column(
                    children: <Widget>[
                      Text("Browse file", style: Theme.of(context).textTheme.bodyText2.copyWith(fontWeight: FontWeight.bold)),
                      Image.asset(Images.uploadVideo, height: 25).vP16,
                      Text("File should be PDF,DOCX,Sheet,Image",
                          style: Theme.of(context).textTheme.bodyText2.copyWith(fontSize: 12, color: PColors.gray)),
                    ],
                  ),
                ).ripple(pickFile),
                Consumer<BatchMaterialState>(
                  builder: (context, state, child) {
                    if (state.file != null) {
                      return SizedBox(
                        height: 65,
                        width: AppTheme.fullWidth(context),
                        child: Column(
                          children: <Widget>[
                            Row(children: <Widget>[
                              SizedBox(
                                  width: 50,
                                  child: Image.asset(
                                    Images.getfiletypeIcon(state.file.path.split(".").last),
                                    height: 30,
                                  )),
                              Text(state.file.path.split("/").last),
                              Spacer(),
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.cancel),
                                  onPressed: () {
                                    state.removeFile();
                                  })
                            ]),
                            Container(
                              height:5,
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              width: AppTheme.fullWidth(context),
                              decoration: BoxDecoration(
                                color: Color(0xff0CC476),
                                borderRadius: BorderRadius.circular(20)
                              ),
                            )
                          ],
                        ),
                      ).vP8;
                    }
                    return SizedBox();
                  },
                ),
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
