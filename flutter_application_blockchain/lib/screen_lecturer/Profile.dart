import 'package:flutter/material.dart';

import '../login_User_All/login.dart';
import 'AttendanceHistoryScreen.dart';
import 'EditProfile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile อาจารย์'),
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
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 25),
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundImage: AssetImage('assets/images/Profile.png'),
                ),
                Positioned(
                  bottom: 140,
                  right: 4,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.8),
                      ),
                      child: Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Align(
              alignment: Alignment.centerLeft,
              child: FractionalTranslation(
                translation: Offset(0.2, 0.0),
                child: Text(
                  'ข้อมูลบัญชี',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    Text(
                      'ชื่อ: Sirichai',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'นามสกุล: chantharasri',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Email: sirichai.c@ku.th',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'รหัสนิสิต: 63402050682222',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 25),
                    Align(
                      child: FractionalTranslation(
                        translation: Offset(0.0, 0.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditProfileScreen(),
                              ),
                            );
                          },
                          child: Text('แก้ไขข้อมูลบัญชี'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
