import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_blockchain/screen_nisit/History_class_nisit_Screen.dart';

import 'package:flutter_application_blockchain/screen_nisit/SubjectDetail_nisit_Screen.dart';

import '../login_User_All/login.dart';

import 'Profile_nisit.dart';

class UserScreen_nisit extends StatefulWidget {
  @override
  _UserScreen_nisitState createState() => _UserScreen_nisitState();
}

class _UserScreen_nisitState extends State<UserScreen_nisit> {
  List<Map<String, String>> subjects = [
    {'code': '01111', 'name': 'วิชาAAA', 'group': '2'},
    {'code': '222', 'name': 'วิชาที่BBB', 'group': '1'},
    {'code': '03333', 'name': 'วิชาที่CCC', 'group': '3'},
  ];

  String? joinedSubjectCode; // Variable to store the joined subject code

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
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }

  void _showJoinClassDialog() {
    TextEditingController codeController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Join a Class"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "You are currently signed in with email:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "sirichai.c@ku.th", // Replace with the user's email
                style: TextStyle(color: Colors.blue),
              ),
              SizedBox(height: 20),
              TextField(
                controller: codeController,
                decoration: InputDecoration(labelText: "Enter Class Code"),
                keyboardType: TextInputType.text,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text("Join Class"),
              onPressed: () {
                String classCode = codeController.text.trim();
                // Check if class code is valid and join the class if needed
                // Replace this with your logic to verify and join the class
                if (isValidClassCode(classCode)) {
                  setState(() {
                    joinedSubjectCode = classCode;
                  });
                  Navigator.of(context).pop();
                  _showJoinSuccessDialog(); // เรียกใช้ฟังก์ชันแสดงข้อความเมื่อสำเร็จ
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Invalid class code.'),
                  ));
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showJoinSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Join Class Successful"),
          content: Text("You have successfully joined the class!"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool isValidClassCode(String classCode) {
    // Replace with your logic to validate the class code
    // Return true if it's a valid class code, otherwise, return false
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User_nisit'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              if (joinedSubjectCode == null) {
                _showJoinClassDialog();
              } else {
                // Handle navigation or display message for already joined class
                // For example, navigate to the subject detail screen for the joined subject
                // Or show a message that the user is already in a class
              }
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
                // Add your code here when clicking on 'วิชาเรียน'
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
                    builder: (context) => History_class_nisit_Screen(),
                  ),
                );
                // Add your code here when clicking on 'ประวัติการเข้าเรียน'
              },
            ),
            SizedBox(
              height: 20,
            ),
            _buildDrawerItem(
              title: 'profile_nisit',
              icon: Icons.manage_accounts,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile_nisitScreen(),
                  ),
                );
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
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 80),
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
                        builder: (context) => SubjectDetail_nisitScreen(
                          subject: subject,
                        ),
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
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ' ${index + 1}',
                              style: TextStyle(
                                color: Colors.green,
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
                      const SizedBox(height: 20),
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
