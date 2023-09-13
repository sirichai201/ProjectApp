import 'package:flutter/material.dart';

import '../screen_nisit/Profile_nisit.dart';
import '../screen_nisit/history_nisit.dart';
import '../screen_nisit/user_nisit.dart';

class DrawerBarNisit extends StatelessWidget {
  const DrawerBarNisit({super.key});

  Widget _buildDrawerItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      // width: MediaQuery.of(context).size.width * 0.7,
      margin:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserNisit(),
                ),
              ); // Add your code here when clicking on 'วิชาเรียน'
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
                MaterialPageRoute(
                  builder: (context) => const HistoryNisit(),
                ),
              );
              // Add your code here when clicking on 'ประวัติการเข้าเรียน'
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
                MaterialPageRoute(
                  builder: (context) => ProfileNisitScreen(),
                ),
              );
            },
          ),
          const SizedBox(
            height: 20,
          ),
          _buildDrawerItem(
            title: 'ออกจากระบบ',
            icon: Icons.exit_to_app,
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => LoginScreen(),
              //   ),
              // );
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
