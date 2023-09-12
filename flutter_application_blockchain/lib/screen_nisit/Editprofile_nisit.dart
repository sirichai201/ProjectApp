import 'package:flutter/material.dart';
import 'package:flutter_application_blockchain/login_User_All/login.dart';
import 'package:flutter_application_blockchain/screen_nisit/History_class_nisit_Screen.dart';
import 'package:flutter_application_blockchain/screen_nisit/Profile_nisit.dart';
import 'package:flutter_application_blockchain/screen_nisit/User_nisit.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class EditProfile_nisitScreen extends StatefulWidget {
  final Map<String, dynamic> userData;
  EditProfile_nisitScreen({required this.userData});

  @override
  _EditProfile_nisitScreenState createState() =>
      _EditProfile_nisitScreenState();
}

class _EditProfile_nisitScreenState extends State<EditProfile_nisitScreen> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _studentIdController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.userData['name']);
    _lastNameController =
        TextEditingController(text: widget.userData['lastName']);
    _emailController = TextEditingController(text: widget.userData['email']);
    _studentIdController =
        TextEditingController(text: widget.userData['studentId']);
  }

  Future<void> _showChangeImageDialog() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File image = File(pickedFile.path);

      // คัดลอกรูปภาพที่เลือกไปยัง directory ของแอป
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String path = appDocDir.path;
      _selectedImage = await image.copy('$path/selectedImage.png');

      setState(
          () {}); // เมื่อค่า _selectedImage มีการเปลี่ยนแปลง setState จะทำให้ UI rebuild
    }
  }

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
        title: Text('แก้ไขข้อมูลบัญชี'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              Map<String, dynamic> updatedData = {
                'name': _nameController.text,
                'lastName': _lastNameController.text,
                'email': _emailController.text,
                'studentId': _studentIdController.text,
              };
              Navigator.pop(context, updatedData);
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
                      builder: (context) => History_class_nisit_Screen()),
                );
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
                      builder: (context) => Profile_nisitScreen()),
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
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: _selectedImage != null
                        ? FileImage(_selectedImage!)
                        : AssetImage('assets/images/Profile.png'),
                  ),
                  Positioned(
                    bottom: 140,
                    right: 4,
                    child: InkWell(
                      onTap: _showChangeImageDialog,
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
            ),
            SizedBox(height: 20),
            Text('ชื่อ:', style: TextStyle(fontSize: 16)),
            TextFormField(
              controller: _nameController,
            ),
            SizedBox(height: 20),
            Text('นามสกุล:', style: TextStyle(fontSize: 16)),
            TextFormField(
              controller: _lastNameController,
            ),
            SizedBox(height: 20),
            Text('Email:', style: TextStyle(fontSize: 16)),
            TextFormField(
              controller: _emailController,
            ),
            SizedBox(height: 20),
            Text('รหัสนิสิต:', style: TextStyle(fontSize: 16)),
            TextFormField(
              controller: _studentIdController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Map<String, dynamic> updatedData = {
                  'name': _nameController.text,
                  'lastName': _lastNameController.text,
                  'email': _emailController.text,
                  'studentId': _studentIdController.text,
                };
                Navigator.pop(context, updatedData);
              },
              child: Text('บันทึก'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _studentIdController.dispose();
    super.dispose();
  }
}
