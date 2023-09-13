import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_blockchain/screen_lecturer/History_class_lecturer_screen.dart';
import 'package:flutter_application_blockchain/screen_lecturer/Profile_lecturer.dart';
import 'package:flutter_application_blockchain/screen_lecturer/User_lecturer.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../login_User_All/login.dart';

class EditProfile_lecturerScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  EditProfile_lecturerScreen({required this.userData});

  @override
  _EditProfile_lecturerScreenState createState() =>
      _EditProfile_lecturerScreenState();
}

class _EditProfile_lecturerScreenState
    extends State<EditProfile_lecturerScreen> {
  late TextEditingController _nameController;
  late TextEditingController _lastNameController;
  late TextEditingController _emailController;
  late TextEditingController _studentIdController;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
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
      _saveImageToAppDirectory(pickedFile);
    }
  }

  Future<void> _saveImageToAppDirectory(PickedFile pickedFile) async {
    File image = File(pickedFile.path);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    _selectedImage = await image.copy('$path/selectedImage.png');
    print(_selectedImage);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: _buildDrawer(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('แก้ไขข้อมูลบัญชี'),
      actions: [
        IconButton(
          icon: Icon(Icons.save),
          onPressed: _saveProfileChanges,
        ),
      ],
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _buildDrawerHeader(),
          SizedBox(height: 20),
          ..._buildDrawerItems(),
        ],
      ),
    );
  }

  DrawerHeader _buildDrawerHeader() {
    return const DrawerHeader(
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
    );
  }

  List<Widget> _buildDrawerItems() {
    return [
      _buildDrawerItem(
        title: 'วิชาเรียน',
        icon: Icons.book,
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => User_lecturerScreen())),
      ),
      SizedBox(height: 20),
      _buildDrawerItem(
        title: 'ประวัติการเข้าเรียน',
        icon: Icons.history,
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => History_class_lecturerScreen(
                      subject: {},
                    ))),
      ),
      SizedBox(height: 20),
      _buildDrawerItem(
        title: 'profile_nisit',
        icon: Icons.manage_accounts,
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => Profile_lecturerScreen())),
      ),
      SizedBox(height: 20),
      _buildDrawerItem(
        title: 'ออกจากระบบ',
        icon: Icons.exit_to_app,
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen())),
      ),
      SizedBox(height: 20),
    ];
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

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfilePicture(),
          SizedBox(height: 20),
          _buildTextField('ชื่อ:', _nameController),
          SizedBox(height: 20),
          _buildTextField('นามสกุล:', _lastNameController),
          SizedBox(height: 20),
          _buildTextField('Email:', _emailController),
          SizedBox(height: 20),
          _buildTextField('รหัสนิสิต:', _studentIdController),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _saveProfileChanges,
            child: Text('บันทึก'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 100,
            backgroundImage: _selectedImage != null
                ? Image.file(_selectedImage!).image
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
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        SizedBox(height: 8.0),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'กรุณากรอก$label',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  void _saveProfileChanges() {
    // ส่งข้อมูลที่ถูกแก้ไขกลับไปยังหน้า Profile_nisit.dart
    Navigator.pop(context, {
      'name': _nameController.text,
      'lastName': _lastNameController.text,
      'email': _emailController.text,
      'studentId': _studentIdController.text,
      'selectedImage': _selectedImage // ส่งไฟล์รูปภาพกลับ
    });
  }
}
