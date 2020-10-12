class Images{
  static const String logo = 'assets/images/logo.png';
  static const String logoText = 'assets/images/logo_text.png';
  static const String back = 'assets/images/icons/back.png';
  static const String cross = 'assets/images/icons/cross.png';
  static const String announcements = 'assets/images/icons/announcement.png';
  static const String peopleWhite = 'assets/images/icons/people_white.png';
  static const String peopleBlack = 'assets/images/icons/people_black.png';
  static const String calender = 'assets/images/icons/calender.png';
  static const String uploadVideo = 'assets/images/icons/upload.png';
  static const String edit = 'assets/images/icons/edit.png';
  static const String upload = 'assets/images/icons/upload_ios.png';
  static const String pdf = 'assets/images/icons/pdf.png';
  static const String image = 'assets/images/icons/image.png';
  static const String epub = 'assets/images/icons/epub.png';
  static const String doc = 'assets/images/icons/doc.png';
  static const String audio = 'assets/images/icons/audio.png';

  static getfiletypeIcon(String type){
    switch (type) {
      case "pdf": return pdf;
      case "png": return image;
      case "jpg": return image;
      case "jpeg": return image;
      case "doc": return doc;
      case "epub": return epub;
      case "mp3": return audio;
      case "mp4": return audio;
      case "docx": return doc;
      default:return doc;
    }
  }
}