import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SubjectDetailScreen extends StatefulWidget {
  final Map<String, String> subject;

  SubjectDetailScreen({required this.subject});

  @override
  _SubjectDetailScreenState createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen> {
  DateTime? selectedDate;
  String selectedDateText = "เลือกวันที่";

  // ตัวแปรสำหรับเก็บเวลาเปิดปิดในการเช็คชื่อ
  TimeOfDay? openTime;
  TimeOfDay? closeTime;

  bool isToggleOn = false;

  void _toggleSwitch(bool value) {
    setState(() {
      isToggleOn = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.subject['name']} (${widget.subject['code']})' ??
              'รายละเอียดรายวิชา',
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ปฎิทินและช่องกำหนดวันที่
                InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today),
                          SizedBox(width: 15),
                          Text(selectedDateText,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(height: 20),

                // ช่องสำหรับรหัสเชิญเข้าชั้นเรียน

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text("  รหัสเชิญ 12332154"),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                SizedBox(height: 20),
                Container(
                  width: 250,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ปุ่มเลือกเวลา
                      IconButton(
                        icon: Icon(Icons.timer),
                        onPressed: () => _selectTime(context),
                      ),
                      SizedBox(width: 15),

                      // ช่องแสดงเวลาเปิดปิด
                      Expanded(
                        child: Text(
                          "${openTime?.format(context) ?? 'เวลาเริ่มต้น'} - ${closeTime?.format(context) ?? 'เวลาสิ้นสุด'}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),

                      // เปิดปิด เวลา สำหรับ ไว้เช็คชื่อ
                      Switch(
                        value: isToggleOn,
                        onChanged: _toggleSwitch,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    thickness: 1, // ความหนาของเส้น Divider
                    color: Color.fromARGB(255, 22, 22, 22), // สีของเส้น Divider
                    height: 10, // ระยะห่างระหว่าง SizedBox กับ PieChartWidget
                  ),
                ),
                SizedBox(height: 0),

                // กล่องรายชื่อคนที่มาเรียน ขาดเรียน และลา
                ExpansionTile(
                  title: Text(
                    'รายชื่อคนที่มาเรียน ขาดเรียน และลา',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: [
                    // ส่วนที่แสดงรายชื่อคนที่มาเรียน
                    ListTile(
                      leading: Icon(Icons.check, color: Colors.green),
                      title: Text('รายชื่อคนที่มาเรียน 1'),
                      onTap: () {
                        // ทำสิ่งที่ต้องการเมื่อกดที่รายการคนที่มาเรียน
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.check, color: Colors.green),
                      title: Text('รายชื่อคนที่มาเรียน 2'),
                      onTap: () {
                        // ทำสิ่งที่ต้องการเมื่อกดที่รายการคนที่มาเรียน
                      },
                    ),
                    // ... (เพิ่มรายชื่อคนที่มาเรียนตามความเหมาะสม) ...

                    // ส่วนที่แสดงรายชื่อคนที่ขาดเรียน
                    ListTile(
                      leading: Icon(Icons.close, color: Colors.red),
                      title: Text('รายชื่อคนที่ขาดเรียน 1'),
                      onTap: () {
                        // ทำสิ่งที่ต้องการเมื่อกดที่รายการคนที่ขาดเรียน
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.close, color: Colors.red),
                      title: Text('รายชื่อคนที่ขาดเรียน 2'),
                      onTap: () {
                        // ทำสิ่งที่ต้องการเมื่อกดที่รายการคนที่ขาดเรียน
                      },
                    ),
                    // ... (เพิ่มรายชื่อคนที่ขาดเรียนตามความเหมาะสม) ...

                    // ส่วนที่แสดงรายชื่อคนที่ลา
                    ListTile(
                      leading:
                          Icon(Icons.hourglass_empty, color: Colors.yellow),
                      title: Text('รายชื่อคนที่ลา 1'),
                      onTap: () {
                        // ทำสิ่งที่ต้องการเมื่อกดที่รายการคนที่ลา
                      },
                    ),
                    ListTile(
                      leading:
                          Icon(Icons.hourglass_empty, color: Colors.yellow),
                      title: Text('รายชื่อคนที่ลา 2'),
                      onTap: () {
                        // ทำสิ่งที่ต้องการเมื่อกดที่รายการคนที่ลา
                      },
                    ),
                    // ... (เพิ่มรายชื่อคนที่ลาตามความเหมาะสม) ...
                  ],
                ),
                SizedBox(height: 100),
                // ส่วนแสดงรายชื่อนักเรียน (กราฟวงกลม)
                PieChartWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ฟังก์ชันเลือกวันที่
  Future<void> _selectDate(BuildContext context) async {
    DateTime? currentDate = DateTime.now();
    DateTime? firstDate = currentDate.subtract(Duration(days: 365));
    DateTime? lastDate = currentDate.add(Duration(days: 365));

    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate != null && selectedDate != currentDate) {
      setState(() {
        selectedDateText =
            "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}";
      });
    }
  }

  // ฟังก์ชันเลือกเวลา
  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      if (openTime == null) {
        // เลือกเวลาเริ่มต้นครั้งแรก
        setState(() {
          openTime = selectedTime;
        });
      } else {
        // เลือกเวลาสิ้นสุดครั้งที่สอง
        setState(() {
          closeTime = selectedTime;
        });
      }
    }
  }
}

// Widget สำหรับแสดงกราฟวงกลม (อย่างง่าย)
class PieChartWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: PieChart(
        PieChartData(
          sections: [
            PieChartSectionData(
              value: 25,
              color: Colors.red,
              title: '25%',
              titleStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              value: 35,
              color: Colors.green,
              title: '35%',
              titleStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            PieChartSectionData(
              value: 40,
              color: Colors.blue,
              title: '40%',
              titleStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
          sectionsSpace:
              0, // ระยะห่างระหว่าง Section (หากต้องการให้ติดกันให้ใส่ 0)
          centerSpaceRadius: 40, // รัศมีของส่วนภายในของกราฟวงกลม
          borderData: FlBorderData(show: false), // แสดงเส้นขอบรอบกราฟวงกลม
          // ระยะห่างระหว่าง Section (หากต้องการให้มีระยะห่างระหว่าง Section)
        ),
      ),
    );
  }
}
