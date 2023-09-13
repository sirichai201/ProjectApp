import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_blockchain/screen_nisit/History_class_nisit_Screen.dart';
import 'package:flutter_application_blockchain/screen_nisit/User_nisit.dart';
import '../login_User_All/login.dart';
import 'Editprofile_nisit.dart';

class Profile_nisitScreen extends StatefulWidget {
  @override
  _Profile_nisitScreenState createState() => _Profile_nisitScreenState();
}

class _Profile_nisitScreenState extends State<Profile_nisitScreen> {
  File? _profileImage;

  Map<String, dynamic> _nisitUserData = {
    'name': 'Sirichai',
    'lastName': 'chantharasri',
    'email': 'sirichai.c@ku.th',
    'studentId': '63402050682222',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile_nisit')),
      drawer: _buildDrawer(),
      body: _buildProfileBody(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Color.fromARGB(255, 26, 107, 173)),
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
          _buildDrawerItem(
            title: 'วิชาเรียน',
            icon: Icons.book,
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => UserScreen_nisit()),
            ),
          ),
          _buildDrawerItem(
            title: 'ประวัติการเข้าเรียน',
            icon: Icons.history,
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => History_class_nisit_Screen()),
            ),
          ),
          _buildDrawerItem(
            title: 'ออกจากระบบ',
            icon: Icons.exit_to_app,
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
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

  Widget _buildProfileBody() {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 25),
          CircleAvatar(
            radius: 100,
            backgroundImage: _profileImage != null
                ? Image.file(_profileImage!).image
                : AssetImage('assets/images/Profile.png'),
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
            child: _buildProfileDetails(),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileDetails() {
    return Container(
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
            'ชื่อ: ${_nisitUserData['name']}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            'นามสกุล: ${_nisitUserData['lastName']}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            'Email: ${_nisitUserData['email']}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            'รหัสนิสิต: ${_nisitUserData['studentId']}',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 25),
          ElevatedButton(
            onPressed: _navigateToEditProfile,
            child: Text('แก้ไขข้อมูล'),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  Future<void> _navigateToEditProfile() async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfile_nisitScreen(userData: _nisitUserData),
      ),
    );

    if (result is Map<String, dynamic>) {
      setState(() {
        _nisitUserData = result;

        // ตรวจสอบว่ามี key 'selectedImage' ใน result หรือไม่
        if (result.containsKey('selectedImage')) {
          _profileImage = result['selectedImage'];
        }
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('แก้ไขข้อมูลสำเร็จ')),
      );
    }
  }
}
