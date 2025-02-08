import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

import '../models/menu_provider.dart';
import '../themes/colors.dart';
import '../widgets/food_menu_bottom_sheet.dart';

class SpinWheelManual extends StatefulWidget {
  final String title;

  const SpinWheelManual({Key? key, required this.title}) : super(key: key);

  @override
  State<SpinWheelManual> createState() => _SpinWheelManualState();
}

class _SpinWheelManualState extends State<SpinWheelManual> {
  final selected = BehaviorSubject<int>();
  final _textController = TextEditingController();

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menuProvider = Provider.of<MenuProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: icons)),
        backgroundColor: primary,
        iconTheme: IconThemeData(color: icons),
        actions: [
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () {
              menuProvider.selectRandomMenu();
            },
          ),
          IconButton(
            icon: Icon(Icons.list_alt),
            onPressed: () {
              _showFoodMenu(context);
            },
          ),
        ],
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
                    children: menuProvider.selectedItems.map((item) {
                      return Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item,
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
          if (menuProvider.selectedItems.length > 1) ...[
            Center(
              child: SizedBox(
                height: 350,
                child: FortuneWheel(
                  selected: selected.stream,
                  animateFirst: false,
                  items:
                      List.generate(menuProvider.selectedItems.length, (index) {
                    return FortuneItem(
                      child: Text(
                        menuProvider.selectedItems[index],
                        style: TextStyle(fontSize: 20),
                      ),
                      style: FortuneItemStyle(
                        color:
                            Colors.primaries[index % Colors.primaries.length],
                      ),
                    );
                  }),
                  onAnimationEnd: () {
                    final selectedIndex = selected.value;
                    final reward = menuProvider.selectedItems[selectedIndex];

                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("เมนูที่คุณสุ่มได้"),
                        content: Text("เมนูของคุณคือ: $reward"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("ตกลง"),
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
                selected.add(
                    Fortune.randomInt(0, menuProvider.selectedItems.length));
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

  void _showFoodMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FoodMenuBottomSheet(textController: _textController);
      },
    );
  }
}
