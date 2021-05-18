class Constants {
  static const String productionBaseUrl = "http://34.222.54.250:3000/api/";
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

  static getMyBatches(bool isStudent) {
    return isStudent ? studentBatch : Constants.batch;
  }

  static String getMyAnnouncement(bool isStudent) {
    return isStudent ? studentAnnouncements : annoucenment;
  }

  static String getMyBatchDetailTimeLine(bool isStudent, String batchId) {
    return isStudent
        ? "$student/$batch/$batchId/timeline"
        : "$batch/$batchId/timeline";
  }

  static String getBatchMaterialList(String batchId) {
    return "$batch/$batchId/$material";
  }

  static String getBatchVideoList(String batchId) {
    return "$batch/$batchId/$video";
  }

  static String getBatchAnnouncementList(String batchId) {
    return "$batch/$batchId/$annoucenment";
  }

  static String uploadDocInAnnouncement(String announcementId) {
    return "$annoucenment/$announcementId/doc/upload";
  }

  static String uploadImageInAnnouncement(String announcementId) {
    return "$annoucenment/$announcementId/upload";
  }

  static String getBatchAssignmentList(String batchId, bool isStudent) {
    return isStudent
        ? "student/$batch/$batchId/$assignment"
        : "$batch/$batchId/$assignment";
  }

  static String getBatchAssignmentDetail(
      String batchId, String assignmentId, bool isStudent) {
    return isStudent
        ? "$student/$batch/$batchId/$assignment/$assignmentId"
        : "$batch/$batchId/$assignment/$assignmentId";
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

  static String crudePoll(String pollId) {
    return "$poll/$pollId";
  }

  static String crudVideo(String id) {
    return "$video/$id";
  }

  static String crudAnnouncement(String id) {
    return "$annoucenment/$id";
  }

  static String crudMaterial(String id) {
    return "$material/$id";
  }

  static String crudAssignment(String id) {
    return "$assignment/$id";
  }
}
