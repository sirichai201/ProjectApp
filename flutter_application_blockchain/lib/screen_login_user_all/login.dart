import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screen_addmin/user_admin.dart';
import '../screen_lecturer/User_lecturer.dart';
import '../screen_nisit/User_nisit.dart';
import 'forget_password.dart';
import 'package:web3dart/web3dart.dart';

class Login extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Login({Key? key}) : super(key: key);

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
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 20.0),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: GestureDetector(
                  onTap: () async {
                    // Step 1: ตรวจสอบข้อมูลของ admin ก่อน
                    if (_usernameController.text == "test00" &&
                        _passwordController.text == "test00") {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => UserAdmin()));
                      return;
                    }

                    // Step 2: ตรวจสอบผ่าน smart contract หากไม่ใช่ admin
                    final http.Client httpClient = http.Client();
                    final Web3Client client = Web3Client("", httpClient);
                    final deployedContract = DeployedContract(
                        ContractAbi.fromJson(''' ''', ""),
                        EthereumAddress.fromHex(""));

                    final authenticateFunction =
                        deployedContract.function("authenticate");
                    try {
                      final authResponse = await client.call(
                        contract: deployedContract,
                        function: authenticateFunction,
                        params: [
                          _usernameController.text,
                          _passwordController.text
                        ],
                      );

                      bool isAuthenticated = authResponse[0] as bool;

                      if (isAuthenticated) {
                        // Step 3: เรียก function checkUserRole
                        final roleFunction =
                            deployedContract.function("checkUserRole");
                        final roleResponse = await client.call(
                          contract: deployedContract,
                          function: roleFunction,
                          params: [_usernameController.text],
                        );

                        String role = roleResponse[0] as String;

                        switch (role) {
                          case "student":
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserNisit()));
                            break;
                          case "teacher":
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserLecturer()));
                            break;
                          default:
                            _showDialog(context, 'Error', 'Invalid Role');
                            break;
                        }
                      } else {
                        _showDialog(
                            context, 'Error', 'Invalid Username or Password');
                      }
                    } catch (e) {
                      print("Error occurred: $e");
                      _showDialog(context, 'Error', e.toString());
                    }
                  },
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

  void _showDialog(BuildContext context, String title, String content) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
