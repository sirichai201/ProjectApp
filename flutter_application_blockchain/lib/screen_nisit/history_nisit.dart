import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_blockchain/screen_nisit/profile_nisit.dart';
import 'package:flutter_application_blockchain/screen_nisit/user_nisit.dart';

import '../screen_login_user_all/login.dart';

class HistoryNisit extends StatefulWidget {
  const HistoryNisit({super.key});

  @override
  State<HistoryNisit> createState() => _HistoryNisitState();
}

class _HistoryNisitState extends State<HistoryNisit> {
  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerItem({
      required String title,
      required IconData icon,
      required VoidCallback onTap,
    }) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.7,
        margin:
            const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
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
        title: const Text('History_class_nisit_Screen'),
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
            const SizedBox(
              height: 20,
            ),
            _buildDrawerItem(
              title: 'วิชาเรียน',
              icon: Icons.book,
              onTap: () {
                // เพิ่มโค้ดที่คุณต้องการเมื่อคลิกที่เมนู 'วิชาเรียน'
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const UserNisit()));
              },
            ),
            const SizedBox(
              height: 20,
            ),
            _buildDrawerItem(
              title: 'ประวัติการเข้าเรียน',
              icon: Icons.history,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HistoryNisit()),
                );
                // เพิ่มโค้ดที่คุณต้องการเมื่อคลิกที่เมนู 'ประวัติการเข้าเรียน'
              },
            ),
            const SizedBox(
              height: 20,
            ),
            _buildDrawerItem(
              title: 'profile_nisit',
              icon: Icons.manage_accounts,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileNisitScreen()),
                ); // ปิด Drawer เมื่อกดปุ่ม "ออก"
              },
            ),
            const SizedBox(
              height: 20,
            ),
            _buildDrawerItem(
              title: 'ออกจากระบบ',
              icon: Icons.exit_to_app,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                ); // ปิด Drawer เมื่อกดปุ่ม "ออก"
              },
            ),
            const SizedBox(
              height: 20,
            ),
            // Add more ListTile items as needed
          ],
        ),
      ),
    );
  }
}
