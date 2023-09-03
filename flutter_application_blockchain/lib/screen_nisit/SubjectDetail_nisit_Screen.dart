import 'package:flutter/material.dart';

import 'package:flutter_application_blockchain/screen_lecturer/AttendanceHistoryScreen.dart';
import 'package:flutter_application_blockchain/screen_lecturer/User_lecturer.dart';
import 'package:flutter_application_blockchain/screen_nisit/User_nisit.dart';

import '../screen_lecturer/login.dart';

class SubjectDetail_nisitScreen extends StatefulWidget {
  final Map<String, String> subject;

  SubjectDetail_nisitScreen({required this.subject});

  @override
  _SubjectDetail_nisitScreenState createState() =>
      _SubjectDetail_nisitScreenState();
}

class _SubjectDetail_nisitScreenState extends State<SubjectDetail_nisitScreen> {
  DateTime? selectedDate;
  String selectedDateText = "เลือกวันที่";

  // ตัวแปรสำหรับเก็บเวลาเปิดปิดในการเช็คชื่อ
  TimeOfDay? openTime;
  TimeOfDay? closeTime;

  bool isToggleOn = false;

  void _toggleSwitch(bool value) {
    setState(() {
      isToggleOn = value;
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.subject['name']} (${widget.subject['code']})' ??
              'รายละเอียดรายวิชา',
        ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserScreen_nisit()),
                );
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
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ปฎิทินและช่องกำหนดวันที่
                InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(width: 15),
                          Text(selectedDateText,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(height: 20),

                // ช่องสำหรับรหัสเชิญเข้าชั้นเรียน

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text("  รหัสเชิญ 12332154"),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                SizedBox(height: 20),
                Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ปุ่มเลือกเวลา
                      IconButton(
                        icon: Icon(Icons.timer),
                        onPressed: () => _selectTime(context),
                      ),
                      SizedBox(width: 15),

                      // ช่องแสดงเวลาเปิดปิด
                      Expanded(
                        child: Text(
                          "${openTime?.format(context) ?? 'เวลาเริ่มต้น'} - ${closeTime?.format(context) ?? 'เวลาสิ้นสุด'}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      // เปิดปิด เวลา สำหรับ ไว้เช็คชื่อ
                      Switch(
                        value: isToggleOn,
                        onChanged: _toggleSwitch,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 1, // ความหนาของเส้น Divider
                    color: Color.fromARGB(255, 22, 22, 22), // สีของเส้น Divider
                    height: 10, // ระยะห่างระหว่าง SizedBox กับ PieChartWidget
                  ),
                ),
                SizedBox(height: 20),

                // กล่องรายชื่อคนที่มาเรียน ขาดเรียน และลา
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 120, // เพิ่มขนาดกว้างของกล่อง DropdownButton
                      child: _buildDropdownButton("มาเรียน", Colors.green),
                    ),
                    SizedBox(width: 8),
                    SizedBox(
                      width: 120, // เพิ่มขนาดกว้างของกล่อง DropdownButton
                      child: _buildDropdownButton("ขาดเรียน", Colors.red),
                    ),
                    SizedBox(width: 8),
                    SizedBox(
                      width: 120, // เพิ่มขนาดกว้างของกล่อง DropdownButton
                      child: _buildDropdownButton("ลา", Colors.yellow),
                    ),
                  ],
                ),

                SizedBox(height: 50),
                // ส่วนแสดงรายชื่อนักเรียน (กราฟวงกลม)
                PieChartWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownButton(String title, Color color) {
    return Container(
      width: 100,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: title, // ให้ Dropdown แสดง title ในแต่ละกล่องเป็นค่า default
          onChanged: (newValue) {
            // ใส่โค้ดที่ต้องการเมื่อกด dropdown และเลือกค่าใหม่
            print('Selected: $newValue');
          },
          items: <String>[title].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    title == "มาเรียน"
                        ? Icons.check_circle // กำหนด Icon สำหรับมาเรียน
                        : title == "ขาดเรียน"
                            ? Icons.cancel // กำหนด Icon สำหรับขาดเรียน
                            : Icons.hourglass_empty, // กำหนด Icon สำหรับลา
                    color: Color.fromARGB(255, 19, 18, 18),
                  ),
                  SizedBox(width: 8), // ระยะห่างระหว่างไอคอนกับข้อความ
                  Text(value,
                      style: TextStyle(color: Color.fromARGB(255, 17, 17, 17))),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ฟังก์ชันเลือกวันที่
  Future<void> _selectDate(BuildContext context) async {
    DateTime? currentDate = DateTime.now();
    DateTime? firstDate = currentDate.subtract(Duration(days: 365));
    DateTime? lastDate = currentDate.add(Duration(days: 365));

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate != null && selectedDate != currentDate) {
      setState(() {
        selectedDateText =
            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      });
    }
  }

  // ฟังก์ชันเลือกเวลา
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      if (openTime == null) {
        // เลือกเวลาเริ่มต้นครั้งแรก
        setState(() {
          openTime = selectedTime;
        });
      } else {
        // เลือกเวลาสิ้นสุดครั้งที่สอง
        setState(() {
          closeTime = selectedTime;
        });
      }
    }
  }
}

// Widget สำหรับแสดงกราฟวงกลม (อย่างง่าย)

  