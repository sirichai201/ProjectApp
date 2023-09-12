import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // สร้างตัวแปรสำหรับเก็บข้อมูลผู้ใช้ที่จะแก้ไข
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _studentIdController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();
  String? _selectedFileName;

  String? _imagePath;

  @override
  void initState() {
    super.initState();
    // กำหนดค่าเริ่มต้นให้กับ TextEditingControllers จากข้อมูลผู้ใช้
    _nameController.text = 'Sirichai';
    _lastNameController.text = 'chantharasri';
    _emailController.text = 'sirichai.c@ku.th';
    _studentIdController.text = '63402050682222';
  }

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedFileName = pickedFile.name;
      });
      // คุณสามารถใช้ pickedFile.path เพื่อใช้ไฟล์รูปภาพที่เลือก
    } else {
      // ผู้ใช้ยกเลิกการเลือกรูปภาพ
    }
  }

  Future<void> _showImageUploadDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('อัพโหลดรูปภาพ'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('โปรดเลือกไฟล์ PNG ที่คุณต้องการอัพโหลด:'),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _pickImage();
                },
                child: Text('เลือกไฟล์'),
              ),
              SizedBox(height: 16.0),
              Text(_selectedFileName ?? ''), // แสดงชื่อไฟล์ที่เลือก
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('ยกเลิก'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('ยืนยัน'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูลบัญชีอาจารย์'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
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
                        _showImageUploadDialog();
                      },
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(
                              255, 78, 79, 80), // สีพื้นหลังของปุ่ม
                          shape: BoxShape.circle, // กำหนดให้มีรูปร่างเป็นวงกลม
                        ),
                        child: Icon(
                          Icons.edit, // ใส่ไอคอนแก้ไข
                          color: Colors.white, // สีไอคอน
                          size: 32.0, // ขนาดไอคอน
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'ชื่อ'),
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'นามสกุล'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextFormField(
                controller: _studentIdController,
                decoration: InputDecoration(labelText: 'รหัสนิสิต'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // ดำเนินการบันทึกข้อมูลที่แก้ไขได้ที่นี่
                  // เมื่อแก้ไขเสร็จสิ้น คุณสามารถใช้ Navigator.pop เพื่อย้อนกลับไปหน้า ProfileScreen
                  Navigator.pop(context, "success");
                },
                child: Text('บันทึกการเปลี่ยนแปลง'),
              ),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
