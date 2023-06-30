import 'package:flutter/material.dart';
import 'package:flutter_application_blockchain/screen/login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text('แอพเช็คชื่อ'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/R 1.png",
                  width: 209,
                  height: 300,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 200,
                  height: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 4.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "เริ่มต้นใช้งาน",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return LoginScreen();
            },
          ));
        },
        child: Icon(Icons.arrow_forward),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
