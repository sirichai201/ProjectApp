import 'package:flutter/material.dart';
import 'package:flutter_application_blockchain/screen/ForgotPassword.dart';
import 'package:flutter_application_blockchain/screen/User.dart';

import 'home.dart';

// นำเข้าหน้าผู้ใช้งานที่กำลังจะสร้าง

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLogoutRequested = false;

    return WillPopScope(
      onWillPop: () async {
        if (isLogoutRequested) {
          return true;
        } else {
          // เมื่อกดปุ่มย้อนกลับ
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('ออกจากระบบ'),
                content: Text('คุณต้องการออกจากระบบหรือไม่?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('ยกเลิก'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // ปิด AlertDialog
                      isLogoutRequested = true;
                      Navigator.of(context)
                          .pop(true); // คืนค่า true ให้กับ onWillPop
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                HomeScreen()), // ใช้ pushReplacement เพื่อให้ HomeScreen เป็นหน้าจอแรกแทนที่หน้า LoginScreen
                      );
                    },
                    child: Text('ออกจากระบบ'),
                  ),
                ],
              );
            },
          );
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('เข้าสู่ระบบ'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/ku.png',
                width: 100,
                height: 150,
              ),
              SizedBox(height: 30.0),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () {
                  // เปลี่ยนไปยังหน้าผู้ใช้งานที่กำลังจะสร้าง
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserScreen()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen(),
                    ),
                  );
                },
                child: Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
