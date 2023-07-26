import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_blockchain/screen/login.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white),
              ),
            ),

            ListTile(
              title: Text('Item2'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Handle item 2 tap
              },
            ),
            ListTile(
              title: Text('ออกจากระบบ'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                ); // ปิด Drawer เมื่อกดปุ่ม "ออก"
              },
              trailing: Icon(
                Icons.exit_to_app, // ใส่ไอคอนเพื่อแสดงให้เห็นว่าเป็นปุ่มออก
                color: Colors.red, // สีแดง
              ),
            )

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
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(20.0),
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
                              color: Colors.green, // สีเขียวสำหรับเลขลำดับวิชา
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 30.0),
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
                            icon: Icon(Icons.delete, color: Colors.red),
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
                    SizedBox(
                        height: 20), // ระยะห่างระหว่างกรอบรายวิชาแต่ละรายการ
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
