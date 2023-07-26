import 'package:flutter/material.dart';

class SubjectDetailScreen extends StatelessWidget {
  final Map<String, String> subject;

  SubjectDetailScreen({required this.subject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subject['code'] ?? 'รายละเอียดรายวิชา'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('รหัสวิชา: ${subject['code']}'),
            Text('ชื่อรายวิชา: ${subject['name']}'),
            Text('หมู่เรียน: ${subject['group']}'),
            // เพิ่มข้อมูลอื่นๆ ของรายวิชาตามต้องการ
          ],
        ),
      ),
    );
  }
}
