import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:qrbats_sp/components/texts/TextBlue.dart';

import '../../../api_services/EventAttendedHistoryService.dart';
import '../../../models/AttendanceHistoryData.dart';

class HistoryPage extends StatefulWidget {
  final String token;
  const HistoryPage({Key? key,  this.token=""}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  late double _fontSizeFactor;
  List<AttendanceData> _attendanceList = [];

  late int studentId;

  @override
  void initState() {
    super.initState();
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    studentId = jwtDecodedToken["studentId"];
    _fetchAttendanceData();
  }

  Future<void> _fetchAttendanceData() async {
    try {
      final List<AttendanceData> attendanceList = await EventAttendedHistoryService.fetchAttendanceList(studentId);
      attendanceList.sort((a, b) => b.attendedDateTime.compareTo(a.attendedDateTime)); // Sort by descending date and time
      setState(() {
        _attendanceList = attendanceList;
        print(attendanceList);
      });
    } catch (e) {
      print('Error fetching attendance data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: screenHeight,
        width: screenWidth,
        child: Column(
          children: [
            SizedBox(height: 10),
            Center(child: TextBlue(text:"Attendance History", fontSize: 20,)),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: screenHeight * 0.7,
                width: screenWidth * 0.95,
                decoration: _buildContainerDecoration(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('No', style: TextStyle(fontSize: 10))),
                        DataColumn(label: Text('EventName', style: TextStyle(fontSize: 10))),
                        DataColumn(label: Text('Attended Date', style: TextStyle(fontSize: 10))),
                        DataColumn(label: Text('Attended Time', style: TextStyle(fontSize: 10))),
                      ],
                      rows: _attendanceList.map((attendance) {
                        return DataRow(cells: [
                          DataCell(Text('${_attendanceList.indexOf(attendance) + 1}', style: TextStyle(fontSize: 10))),
                          DataCell(Text(attendance.eventName, style: TextStyle(fontSize: 10))),
                          DataCell(Text('${attendance.attendedDateTime.toString().split(' ')[0]}', style: TextStyle(fontSize: 10))),
                          DataCell(Text('${attendance.attendedDateTime.toString().split(' ')[1].split('.')[0]}', style: TextStyle(fontSize: 10))),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border(
        top: BorderSide(
          color: Color(0xFF086494),
          width: 6.0,
        ),
        bottom: BorderSide(
          color: Color(0xFF086494),
          width: 1.0,
        ),
        left: BorderSide(
          color: Color(0xFF086494),
          width: 1.0,
        ),
        right: BorderSide(
          color: Color(0xFF086494),
          width: 1.0,
        ),
      ),
    );
  }
}
