class ApiConstants {
  static const String baseUrl = 'http://192.168.1.11:8080';
  static const String mobileBaseUrl = 'http://192.168.1.11:8081';
  static const String baseUrlEmulater = 'http://10.0.2.2:8080';
  static const String checkStudentEmailEndpoint = '/api/v1/mobile/checkstudentemail';
  static const String checkStudentIndexNoEndpoint = '/api/v1/mobile/checkstudentindexno';
  static const String checkStudentUserNameEndpoint = '/api/v1/mobile/checkstudentusername';
  static const String studentRegister = '/api/v1/mobile/signup';
  static const String studentlogin = '/api/v1/mobile/signin';
  static const String studentGenerateOTP = '/api/v1/otp/generateotp';
  static const String studentVerifyOtp = '/api/v1/otp/otpverification';
  static const String markAttendanceEndpoint = '/api/v1/attendance/markattendance';
  static const String getallattendancebystudentidEndpoint = '/api/v1/attendance/getallattendancebystudentid';
}
