import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import '../screen_nisit/User_nisit.dart';
import 'forget_password.dart';
import 'package:http/http.dart' as http;
// นำเข้าหน้าผู้ใช้งานที่กำลังจะสร้าง

// ignore: must_be_immutable
class Login extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Login({Key? key}) : super(key: key);

  String username = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('เข้าสู่ระบบ')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/ku.png',
                width: 100,
                height: 150,
              ),
              const SizedBox(height: 30.0),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                onChanged: (value) {
                  username = value;
                },
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(height: 20.0),
              GestureDetector(
                onTap: () async {
                  // String json = convert.jsonEncode(<String, dynamic>{
                  //   "username": username,
                  //   "password": password,
                  // });
                  // var url = Uri.http('192.168.1.12:3000', '/api/login', {});

                  // // Await the http get response, then decode the json-formatted response.

                  // var response = await http.post(url,
                  //     headers: {"Content-Type": "application/json"},
                  //     body: json);
                  // if (response.statusCode == 200) {
                  //   var jsonDecoded = convert.jsonDecode(response.body);
                  //   var user = jsonDecoded['user'];
                  //   String name = "";
                  //   try {
                  //     name = "${user['first_name']} ${user['last_name']}";
                  //   } catch (err) {
                  //     name = "catch";
                  //   }
                  //   // ignore: use_build_context_synchronously
                  //   Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => UserNisit(
                  //                 nameFull: name,
                  //               )));
                  // } else {
                  //   // ignore: use_build_context_synchronously
                  //   showDialog<void>(
                  //     context: context,
                  //     builder: (BuildContext context) {
                  //       return AlertDialog(
                  //         title: const Text('Error'),
                  //         content: const Text("Login Error"),
                  //         actions: <Widget>[
                  //           TextButton(
                  //             style: TextButton.styleFrom(
                  //               textStyle:
                  //                   Theme.of(context).textTheme.labelLarge,
                  //             ),
                  //             child: const Text('Close'),
                  //             onPressed: () {
                  //               Navigator.of(context).pop();
                  //             },
                  //           ),
                  //         ],
                  //       );
                  //     },
                  //   );
                  // }
                  // เปลี่ยนไปยังหน้าผู้ใช้งานที่กำลังจะสร้าง
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const UserNisit()),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForgetPassword(),
                    ),
                  );
                },
                child: const Text('Forgot Password?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
