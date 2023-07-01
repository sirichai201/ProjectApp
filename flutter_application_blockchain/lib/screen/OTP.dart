// ignore: file_names
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_application_blockchain/screen/ResetPassword.dart';

class OTPScreen extends StatefulWidget {
  final TextEditingController _otpController = TextEditingController();
  final String email;

  OTPScreen({Key? key, required this.email}) : super(key: key);

  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int countdown = 120;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (countdown < 1) {
          timer.cancel();
        } else {
          countdown--;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('กรอกรหัส OTP'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              'OTP ถูกส่งไปที่อีเมล์: ${widget.email}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            TextField(
              controller: widget._otpController,
              decoration: InputDecoration(labelText: 'กรอกเลข OTP'),
            ),
            SizedBox(height: 10),
            Text(
              'อายุรหัสผ่าน OTP จะหมดในเวลา $countdown วินาที',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                setState(() {
                  countdown =
                      120; // รีเซ็ตค่า countdown เป็น 120 (หรือค่าที่ต้องการ)
                }); // ส่งรหัสผ่านใหม่อีกครั้ง
              },
              child: Text('ส่งรหัสผ่านใหม่อีกครั้ง'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // ตรวจสอบและยืนยัน OTP
                String otp = widget._otpController.text;
                // เพิ่มโค้ดเพื่อตรวจสอบและยืนยัน OTP
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResetPasswordScreen(
                            email: '',
                            fullName: '',
                            studentID: '',
                          )),
                );
              },
              child: Text('ยืนยัน'),
            ),
          ],
        ),
      ),
    );
  }
}
