class QRCodeDetails {
  int eventId;
  String eventName;
  String? moduleName;
  String eventDate;
  String eventValidDate;
  String eventTime;
  String eventEndTime;
  String eventVenue;
  int eventAssignedUserId;

  QRCodeDetails({
    required this.eventId,
    required this.eventName,
    this.moduleName,
    required this.eventDate,
    required this.eventValidDate,
    required this.eventTime,
    required this.eventEndTime,
    required this.eventVenue,
    required this.eventAssignedUserId,
  });

  factory QRCodeDetails.fromJson(Map<String, dynamic> json) {
    return QRCodeDetails(
      eventId: json['eventId'],
      eventName: json['eventName'],
      moduleName: json['moduleName'],
      eventDate: json['eventDate'],
      eventValidDate: json['eventValidDate'],
      eventTime: json['eventTime'],
      eventEndTime: json['eventEndTime'],
      eventVenue: json['eventVenue'],
      eventAssignedUserId: json['eventAssignedUserId'],
    );
  }
}
