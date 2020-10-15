class Constants{
  static const String productionBaseUrl = "https://pensil-staging.herokuapp.com/api/";

  static const String developmentBaseUrl = "https://pensil-staging.herokuapp.com/";
  static const String batch = "batch";
  static const String createAnnouncement = 'announcement';
  static const String login = 'login';
  static const String poll = 'poll';
  static const String video = 'video';
  static const String material = 'material';
  static const String subjects = 'subjects';
  static const String getAllStudentList = "get-all-student-list";
  static const String studentNotificationList = "student/my-notifications";

  static String getBatchMaterialList(String batchId){
    return "$batch/$batchId/$material";
  }
  static String getBatchVideoList(String batchId){
    return "$batch/$batchId/$video";
  }
}