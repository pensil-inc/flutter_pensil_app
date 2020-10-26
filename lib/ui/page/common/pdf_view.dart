import 'dart:developer';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pensil_app/helper/utility.dart';
import 'package:flutter_pensil_app/ui/theme/theme.dart';

class PdfViewPage extends StatefulWidget {
  PdfViewPage({Key key, this.path, this.title}) : super(key: key);
  final String path;
  final String title;

  static MaterialPageRoute getRoute(String path, {String title}) {
    return MaterialPageRoute(
        builder: (_) => PdfViewPage(
              path: path,
              title: title,
            ));
  }

  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  bool _isLoading = true;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  PDFDocument document;
  @override
  void initState() {
    super.initState();
    changePDF();
  }

  changePDF() async {
    try {
      document = await PDFDocument.fromURL(widget.path);
      _isLoading = false;
      setState(() {});
    } catch (error) {
      log(error.toString(), name: "PdfViwer");
      Utility.displaySnackbar(context,key: scaffoldKey, msg: "File not found on server");
      Future.delayed(Duration(seconds:1)).then((value) => Navigator.pop(context));
    }
  }

  @override
  void dispose() {
    // document.``
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key:scaffoldKey,
      appBar: AppBar(
        title: Title(
          color: PColors.black,
          child: Text(widget.title ?? "Document"),
        ),
      ),
      body: Center(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : PDFViewer(
                document: document,
                zoomSteps: 1,
                //uncomment below line to preload all pages
                lazyLoad: false,
                // uncomment below line to scroll vertically
                scrollDirection: Axis.vertical,
                showPicker: true,
                //uncomment below code to replace bottom navigation with your own
                navigationBuilder: (context, page, totalPages, jumpToPage, animateToPage) {
                  return Container(
                    decoration: AppTheme.decoration(context),
                    child: ButtonBar(
                      alignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.first_page),
                          onPressed: () {
                            // jumpToPage()(page: 0);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            animateToPage(page: page - 2);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward),
                          onPressed: () {
                            animateToPage(page: page);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.last_page),
                          onPressed: () {
                            jumpToPage(page: totalPages - 1);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
