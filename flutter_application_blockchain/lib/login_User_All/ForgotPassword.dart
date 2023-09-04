import 'package:flutter/material.dart';

import 'OTP.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();

  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ลืมรหัสผ่าน'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ลืมรหัสผ่าน',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'กรุณากรอกข้อมูลด้านล่างเพื่อกู้คืนรหัสผ่านของคุณ',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'อีเมล์'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'ชื่อ - นามสกุล'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _studentIdController,
              decoration: InputDecoration(labelText: 'รหัสนิสิต'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OTPScreen(
                            email: '',
                          )),
                );
                // Perform OTP verification logic here
                // You can access the entered values using the controller's text property
              },
              child: Text('หน้าถัดไป'),
            ),
          ],
        ),
      ),
    );
  }
}
