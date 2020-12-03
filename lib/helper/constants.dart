class Constants {
  static const String productionBaseUrl = "http://34.222.54.250:3000/api/";
  static const String shaanAppBaseUrl = "http://34.222.54.250:3002/api/";
  static const String bramhAppBaseUrl = "http://34.222.54.250:3001/api/";

  static const String developmentBaseUrl =
      "https://pensil-staging.herokuapp.com/api";
  static const String batch = "batch";
  static const String annoucenment = 'announcement';
  static const String assignment = 'assignment';
  static const String login = 'login';
  static const String profile = 'profile';
  static const String googleAuth = 'auth/google';
  static const String register = 'register';
  static const String forgotPassword = 'auth/reset-password';
  static const String verifyOtp = 'verify-otp';
  static const String poll = 'poll';
  static const String video = 'video';
  static const String material = 'material';
  static const String subjects = 'subjects';
  static const String student = 'student';
  static const String getAllStudentList = "get-all-student-list";
  static const String studentNotificationList = "student/my-notifications";

  static const String studentBatch = student + "/my-batches";
  static const String studentAnnouncements = student + "/my-announcements";
  static const String studentPolls = student + "/my-polls";

  static String getBatchMaterialList(String batchId) {
    return "$batch/$batchId/$material";
  }

  static String getBatchVideoList(String batchId) {
    return "$batch/$batchId/$video";
  }

  static String getBatchAnnouncementList(String batchId) {
    return "$batch/$batchId/$annoucenment";
  }

  static String getBatchAssignmentList(String batchId) {
    return "$batch/$batchId/$assignment";
  }

  static String getBatchAssignmentDetail(String batchId, String assignmentId) {
    return "$student/$batch/$batchId/$assignment/$assignmentId";
  }

  static String castStudentVotOnPoll(String pollId) {
    return "student/poll/$pollId/vote";
  }

  static String editBatchDetail(String batchId) {
    return "$batch/$batchId";
  }

  static String deleteBatch(String batchId) {
    return "$batch/$batchId";
  }

  static String deleteVideo(String id) {
    return "$video/$id";
  }

  static String deleteMeterial(String id) {
    return "$material/$id";
  }
}
