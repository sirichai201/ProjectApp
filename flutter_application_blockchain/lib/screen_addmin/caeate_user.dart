// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';

import 'user_admin.dart';

// คลาสสำหรับการสร้างบัญชีผู้ใช้
class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  late Web3Client _client;
  late DeployedContract _contract;
  late ContractFunction _createUserFunction;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _dropdownValue = 'นิสิต';

  final abiString = '''[
    
  ]''';
  @override
  void initState() {
    super.initState();
    _initializeWeb3();
  }

  _initializeWeb3() async {
    // ตั้งค่า Web3Client ด้วย endpoint ของ Ethereum node
    _client = Web3Client("http://192.168.1.2:7545", http.Client());

    // สร้าง DeployedContract object โดยอ่าน ABI และ address ของสมาร์ทคอนแทร็กต์
    _contract = DeployedContract(
      ContractAbi.fromJson(abiString, 'UniversityAuthentication'),
      EthereumAddress.fromHex('0x0f686C7422C31e0f31061dE2dCE272e16645Ec5B'),
    );

    // ดึง function ที่ต้องการจากสมาร์ทคอนแทร็กต์
    _createUserFunction = _contract.function('createUser');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('สร้างบัญชี'),
        leading: IconButton(
          // ปุ่มย้อนกลับ
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        UserAdmin())); // ย้อนกลับไปหน้าก่อนหน้า
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            buildUsernameField(),
            const SizedBox(height: 16),
            buildPasswordField(),
            const SizedBox(height: 16),
            buildDropdown(),
            const SizedBox(height: 16),
            buildCreateButton(context),
          ],
        ),
      ),
    );
  }

  TextField buildUsernameField() {
    return TextField(
      controller: _usernameController,
      decoration: const InputDecoration(
        labelText: 'Username',
      ),
    );
  }

  TextField buildPasswordField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Password',
      ),
    );
  }

  DropdownButton<String> buildDropdown() {
    return DropdownButton<String>(
      value: _dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      onChanged: (String? newValue) {
        setState(() {
          _dropdownValue = newValue!;
        });
      },
      items: <String>['นิสิต', 'อาจารย์']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  ElevatedButton buildCreateButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // ตั้งค่า Ethereum address และ privateKey
        final myAddress = '';
        final myPrivateKey = '';

        // 1. ใช้ function 'users' เพื่อดึงข้อมูลผู้ใช้
        final result = await _client.call(
          contract: _contract,
          function: _contract.function('users'),
          params: [_usernameController.text],
        );

        final userAddress = EthereumAddress.fromHex(result[2] as String);

        if (userAddress.hex != myAddress) {
          _showDialog(context, 'มีผู้ใช้นี้อยู่แล้วในระบบ');
          return;
        }

        // 2. ถ้าไม่มีผู้ใช้นี้ สร้างบัญชีใหม่
        final credentials =
            await _client.credentialsFromPrivateKey(myPrivateKey);
        final role = _dropdownValue == 'นิสิต' ? 0 : 1;

        try {
          final txHash = await _client.sendTransaction(
            credentials,
            Transaction.callContract(
              contract: _contract,
              function: _createUserFunction,
              parameters: [
                _usernameController.text,
                _passwordController.text,
                BigInt.from(role),
              ],
            ),
          );

          _showDialog(context, 'ธุรกรรมสำเร็จ: $txHash');
        } catch (e) {
          print(e);
          _showDialog(context, 'เกิดข้อผิดพลาด: $e');
        }
      },
      child: Text('สร้างบัญชี'),
    );
  }

  _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('สถานะการทำธุรกรรม'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('ปิด'),
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
