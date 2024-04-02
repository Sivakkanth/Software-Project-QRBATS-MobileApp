class AttendanceData {
  final String eventName;
  final DateTime attendedDateTime;

  AttendanceData({
    required this.eventName,
    required this.attendedDateTime,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    return AttendanceData(
      eventName: json['eventName'],
      attendedDateTime: DateTime.parse(json['attendedDate'] + ' ' + json['attendedTime']),
    );
  }
}