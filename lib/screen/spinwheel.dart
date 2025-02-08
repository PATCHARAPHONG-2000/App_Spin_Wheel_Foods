import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:rxdart/rxdart.dart';

import '../models/fireworks_screen.dart';
import '../themes/colors.dart';

class SpinWheel extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> selectedItems; // รับค่ารายการที่ถูกส่งมา

  const SpinWheel({
    Key? key,
    required this.title,
    required this.selectedItems, // กำหนดให้รับข้อมูล
  }) : super(key: key);

  @override
  State<SpinWheel> createState() => _SpinWheelState();
}

class _SpinWheelState extends State<SpinWheel> {
  final selected = BehaviorSubject<int>();
  late List<Map<String, dynamic>> items; // กำหนดตัวแปรให้ใช้ `late`

  @override
  void initState() {
    super.initState();
    _loadSelectedItems();
  }

  void _loadSelectedItems() {
    setState(() {
      items = widget.selectedItems.isNotEmpty
          ? widget.selectedItems
          : [
              {'name': 'ไม่มีเมนูอาหาร', 'ingredient': ''}
            ]; // ถ้าไม่มีข้อมูล ก็แสดงข้อความนี้
    });
  }

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: icons)),
        backgroundColor: primary,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        iconTheme: IconThemeData(color: icons),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: primary, width: 1.2),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 2.0,
                    runSpacing: 2.0,
                    children: items.map((item) {
                      return Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${item['name']}: ${item['ingredient']}',
                            style: TextStyle(color: primaryText),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          if (items.length > 1) ...[
            Center(
              child: SizedBox(
                height: 350,
                child: FortuneWheel(
                  selected: selected.stream,
                  animateFirst: false,
                  items: List.generate(items.length, (index) {
                    return FortuneItem(
                      child: Text(
                          '${items[index]['name']}: ${items[index]['ingredient']}',
                          style: TextStyle(fontSize: 20)),
                      style: FortuneItemStyle(
                        color:
                            Colors.primaries[index % Colors.primaries.length],
                      ),
                    );
                  }),
                  onAnimationEnd: () {
                    final selectedIndex = selected.value;
                    final reward = items[selectedIndex];

                    showDialog(
                      context: context,
                      builder: (context) => Stack(
                        children: [
                          FireworksDemo(), // This will play automatically when built
                          Center(
                            child: AlertDialog(
                              title: Text(
                                "อาหารที่คุณสุ่มได้  คือ:",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'NotoSansThai',
                                ),
                              ),
                              content: Text(
                                "${reward['name']} ${reward['ingredient']}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'NotoSansThai',
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("ตกลง"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                selected.add(Fortune.randomInt(0, items.length));
              },
              child: Text("SPIN"),
            ),
          ] else ...[
            Center(
              child: Text("ไม่มีเมนูสำหรับหมุน",
                  style: TextStyle(fontSize: 18, color: Colors.black)),
            ),
          ],
        ],
      ),
    );
  }
}
