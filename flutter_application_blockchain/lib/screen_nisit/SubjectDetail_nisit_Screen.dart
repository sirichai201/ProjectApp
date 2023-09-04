import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_application_blockchain/screen_lecturer/AttendanceHistoryScreen.dart';
import 'package:flutter_application_blockchain/screen_lecturer/User_lecturer.dart';
import 'package:flutter_application_blockchain/screen_nisit/User_nisit.dart';
import '../login_User_All/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubjectDetail_nisitScreen extends StatefulWidget {
  final Map<String, String> subject;

  SubjectDetail_nisitScreen({required this.subject});

  @override
  _SubjectDetail_nisitScreenState createState() =>
      _SubjectDetail_nisitScreenState();
}

//สร้างคลาส User สำหรับเก็บข้อมูลผู้ใช้:
class User {
  final String name;

  User({required this.name});
}

//สร้างคลาส Subject สำหรับเก็บข้อมูลวิชา:
class Subject {
  final String name;
  final String code;

  Subject({required this.name, required this.code});
}

class _SubjectDetail_nisitScreenState extends State<SubjectDetail_nisitScreen> {
  String locationName = 'มหาวิทยาลัยเกษตรศาสตร์ สกลนคร'; // ค่าเริ่มต้น

  double latitude = 13.7563; // ละติจูดตั้งต้น
  double longitude = 100.5018; // ลองจิจูดตั้งต้น

  String userName = '';
  String subjectName = '';

  @override
  void initState() {
    super.initState();
    final user = User(name: 'ชื่อของผู้ใช้'); // เปลี่ยนเป็นข้อมูลผู้ใช้จริง
    final subject = Subject(
        name: 'ชื่อวิชา', code: 'รหัสวิชา'); // เปลี่ยนเป็นข้อมูลวิชาจริง
    userName = user.name;
    subjectName = '${subject.name} (${subject.code})';
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

//สร้างเมธอดเพื่ออัปเดตชื่อตำแหน่งเมื่อมีการเปลี่ยนแปลง:
  void updateLocationName(String newName) {
    setState(() {
      locationName = newName;
    });
  }

// ฟังก์ชันสร้าง Google Map
  Widget _buildGoogleMap() {
    return Column(
      children: [
        Container(
          height: 300, // กำหนดความสูงของแผนที่
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(latitude, longitude), // ตำแหน่งเริ่มต้นของแผนที่
              zoom: 15, // ระดับการซูมเริ่มต้น
            ),
            markers: {
              Marker(
                markerId: MarkerId('selected_location'),
                position: LatLng(latitude, longitude),
              ),
            },
          ),
        ),
        SizedBox(height: 10), // ระยะห่างระหว่างแผนที่กับข้อมูลด้านล่าง
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ละติจูด: $latitude'),
                  SizedBox(width: 20), // ระยะห่างระหว่าง Text
                  Text('ลองจิจูด: $longitude'),
                ],
              ),
              SizedBox(height: 10), // ระยะห่างระหว่างข้อมูลและกรอบ
              Container(
                padding: EdgeInsets.all(8.0), // ระยะห่างรอบข้อความในกรอบ
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black), // สีขอบของกรอบ
                  borderRadius:
                      BorderRadius.circular(8.0), // กำหนดรูปแบบของกรอบ
                ),
                child: Text(
                  locationName, // ใช้ชื่อตำแหน่งที่เรากำหนด
                  style: TextStyle(
                    fontSize: 16.0, // ขนาดตัวอักษร
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

//สร้างฟังก์ชันเพื่อบันทึกสถานะ Check In:
  Future<void> _saveCheckInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'checkedIn', false); // บันทึกสถานะ Check In ว่าเกิดขึ้นแล้ว
  }

//สร้างฟังก์ชันเพื่อตรวจสอบสถานะการ Check In และแสดงข้อความ:
  Future<void> _checkAndShowCheckInStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkedIn = prefs.getBool('checkedIn') ??
        false; // อ่านสถานะ Check In และตั้งค่าเริ่มต้นเป็น false ถ้ายังไม่มีค่า

    if (checkedIn) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('คุณได้ Check In ไปแล้ว'),
            content: Text('คุณไม่สามารถ Check In ซ้ำได้อีก'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // ปิด dialog
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: Text('ตกลง'),
              ),
            ],
          );
        },
      );
    } else {
      _showCheckInDialog(); // แสดงหน้าต่าง Check In ปกติ
    }
  }

  void _showCheckInDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green,
          title: Text('คุณต้องการยืนยันการรับเหรียญ'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ชื่อ: $userName',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                'วิชา: ${widget.subject['name']} (${widget.subject['code']})',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.green,
                ),
                child: Text(
                  'KU COIN +0.5',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // ปิด AlertDialog นี้
                _checkAndShowCheckInStatus(); // เรียกตรวจสอบและแสดงสถานะการ Check In อีกครั้ง
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: Text('ยืนยัน'),
            ),
          ],
        );
      },
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
                _buildGoogleMap(), // เรียกใช้งาน Google Map ที่สร้างขึ้น

                //SizedBox(height: 20),

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
                Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _showCheckInDialog(); // เรียกฟังก์ชันเมื่อกดปุ่ม "Check In"
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    child: Text('Check In'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
