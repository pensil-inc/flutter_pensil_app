import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UsernameWidget extends StatefulWidget {
  final String name;
  final double radius;
  final Color backGroundColor;
  final String avatarUrl;
  final TextStyle textStyle;
  final File fileImage;
  UsernameWidget(
      {Key key,
      this.name,
      this.radius,
      this.backGroundColor = Colors.white,
      this.textStyle = const TextStyle(color: Colors.black),
      this.avatarUrl,
      this.fileImage})
      : super(key: key);

  @override
  _UsernameWidgetState createState() => _UsernameWidgetState();
}

class _UsernameWidgetState extends State<UsernameWidget> {
  String getName() {
    var name = widget.name;
    if (name == null || name.isEmpty) {
      return '';
    } else {
      var splitname = name.split(' ').toList();
      if (splitname.length == 1) {
        return splitname[0].substring(0, 1);
      } 
      else if (splitname.length > 1) {
        return splitname[0].substring(0, 1).toUpperCase() +
            ' ' +
            splitname[1].substring(0, 1).toUpperCase();
      } else if (splitname.length == 3) {
        return splitname[0].substring(0, 1) +
            ' ' +
            splitname[1].substring(0, 1) +
            ' ' +
            splitname[2].substring(0, 1);
      } else {
        return '';
      }
    }
  }

  Widget _getProfilePic() {
    String path = widget.avatarUrl;
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: path,
      placeholder: (context, string) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _getNameImage() {
    return CircleAvatar(
      radius: widget.radius,
      backgroundColor: widget.backGroundColor,
      child: Text(
        getName(),
        style: widget.textStyle,
      ),
    );
  }

  Widget _getImageFromFile() {
    return Image.file(
      widget.fileImage,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fileImage != null) {
      // print("Emoty file");
    }
    // print("Image Url from API:- ${widget.avatarUrl}");
    return Container(
      child: AspectRatio(
        aspectRatio: 1,
        child: widget.fileImage != null
            ? _getImageFromFile()
            : widget.avatarUrl == null || widget.avatarUrl.isEmpty
                ? _getNameImage()
                : _getProfilePic(),
      ),
    );
  }
}
