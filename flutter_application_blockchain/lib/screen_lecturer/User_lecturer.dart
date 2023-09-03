import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_application_blockchain/screen_lecturer/login.dart';

import 'AttendanceHistoryScreen.dart';
import 'Profile.dart';
import 'SubjectDetailScreen.dart';

class User_lecturerScreen extends StatefulWidget {
  @override
  _User_lecturerScreenState createState() => _User_lecturerScreenState();
}

class _User_lecturerScreenState extends State<User_lecturerScreen> {
  List<Map<String, String>> subjects = [
    {'code': '000011111', 'name': 'วิชาAAA', 'group': '2'},
    {'code': '000011111', 'name': 'วิชาที่BBB', 'group': '1'},
    {'code': '000011111', 'name': 'วิชาที่CCC', 'group': '3'},
  ];

  Future<bool?> _showDeleteConfirmationDialog(BuildContext context, int index) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("ยืนยันการลบ"),
          content: Text("คุณต้องการลบรายวิชานี้ใช่หรือไม่?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("ยกเลิก"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("ลบ"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDrawerItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      margin: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
      decoration: BoxDecoration(
        border:
            Border.all(color: Colors.grey, width: 2), // กำหนดเส้นโครงของกรอบ
        borderRadius: BorderRadius.circular(
            10.0), // กำหนดขอบเส้นโครงเป็นรูปสี่เหลี่ยมเหลี่ยม
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }

  void _addSubject() {
    TextEditingController codeController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController groupController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("เพิ่มรายการวิชาใหม่"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: codeController,
                decoration: InputDecoration(labelText: "รหัสวิชา"),
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[ก-๙a-zA-Z0-9]')),
                ],
              ),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "ชื่อรายวิชา"),
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[ก-๙a-zA-Z0-9]')),
                ],
              ),
              TextField(
                controller: groupController,
                decoration: InputDecoration(labelText: "หมู่เรียน"),
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[ก-๙a-zA-Z0-9]')),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("ยกเลิก"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("เพิ่ม"),
              onPressed: () {
                String newCode = codeController.text.trim();
                String newName = nameController.text.trim();
                String newGroup = groupController.text.trim();

                if (newCode.isNotEmpty &&
                    newName.isNotEmpty &&
                    newGroup.isNotEmpty &&
                    !_subjectExists(newCode, newGroup)) {
                  setState(() {
                    subjects.add(
                        {'code': newCode, 'name': newName, 'group': newGroup});
                  });
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'กรุณากรอกรหัสวิชาและหมู่เรียนที่ไม่ซ้ำกันและไม่เป็นค่าว่าง'),
                  ));
                }
              },
            ),
          ],
        );
      },
    );
  }

  bool _subjectExists(String code, String group) {
    return subjects
        .any((subject) => subject['code'] == code && subject['group'] == group);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _addSubject(); // สร้างฟังก์ชัน _addSubject() ที่จะถูกเรียกเมื่อกดปุ่ม
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 26, 107, 173),
              ),
              child: Center(
                child: Text(
                  'เมนู',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _buildDrawerItem(
              title: 'วิชาเรียน',
              icon: Icons.book,
              onTap: () {
                // เพิ่มโค้ดที่คุณต้องการเมื่อคลิกที่เมนู 'วิชาเรียน'
              },
            ),
            SizedBox(
              height: 20,
            ),
            _buildDrawerItem(
              title: 'ประวัติการเข้าเรียน',
              icon: Icons.history,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AttendanceHistoryScreen(
                            subject: {},
                          )),
                );
                // เพิ่มโค้ดที่คุณต้องการเมื่อคลิกที่เมนู 'ประวัติการเข้าเรียน'
              },
            ),
            SizedBox(
              height: 20,
            ),
            _buildDrawerItem(
              title: 'profile',
              icon: Icons.manage_accounts,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                ); // ปิด Drawer เมื่อกดปุ่ม "ออก"
              },
            ),
            SizedBox(
              height: 20,
            ),
            _buildDrawerItem(
              title: 'ออกจากระบบ',
              icon: Icons.exit_to_app,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                ); // ปิด Drawer เมื่อกดปุ่ม "ออก"
              },
            ),
            SizedBox(
              height: 20,
            ),
            // Add more ListTile items as needed
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 80), // ระยะห่างระหว่างข้อความและรายวิชา
          Expanded(
            child: ListView.builder(
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subject = subjects[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SubjectDetailScreen(subject: subject),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        margin: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[300], // สีเทาสำหรับกรอบรายวิชา
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' ${index + 1}',
                              style: TextStyle(
                                color:
                                    Colors.green, // สีเขียวสำหรับเลขลำดับวิชา
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 60.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'รหัสวิชา: ${subject['code']}',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                  Text(
                                    'ชื่อรายวิชา: ${subject['name']}',
                                    style: TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Text(
                                    'หมู่เรียน: ${subject['group']}',
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () async {
                                bool? shouldDelete =
                                    await _showDeleteConfirmationDialog(
                                        context, index);
                                if (shouldDelete == true) {
                                  setState(() {
                                    subjects.removeAt(index);
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                          height: 20), // ระยะห่างระหว่างกรอบรายวิชาแต่ละรายการ
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
