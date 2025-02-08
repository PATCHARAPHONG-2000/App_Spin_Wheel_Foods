import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screen/spinwheel.dart';
import '../cart_provider.dart';

class SelectedItemsSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        List<Map<String, dynamic>> selectedItems =
            cart.cartItems.entries.map((entry) {
          return {
            'name': entry.value['name'],
            'ingredient': entry.key,
            'count': entry.value['count']
          };
        }).toList(); // ดึงข้อมูลจาก CartProvider

        return Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // ปิดหน้าปัจจุบัน
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SpinWheel(
                            title: 'วงล้อสุ่มอาหาร',
                            selectedItems: selectedItems,
                          ),
                          settings: RouteSettings(
                              arguments:
                                  selectedItems), // ส่งข้อมูลไปใน arguments
                        ),
                      );
                    },
                    child: const Text('ตกลง',
                        style: TextStyle(color: Colors.blue)),
                  ),
                  Expanded(
                    flex: 5,
                    child: Center(
                      child: Text(
                        'รายการที่เลือก',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      cart.clearCart(); // เคลียร์ตะกร้า
                      Navigator.pop(context);
                    },
                    child:
                        Icon(Icons.delete_forever, color: Colors.red, size: 30),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: selectedItems.length,
                  itemBuilder: (context, index) {
                    String menuItem = selectedItems[index]['ingredient'];
                    String name = selectedItems[index]['name'];
                    int count = selectedItems[index]['count'];
                    return ListTile(
                      title: Text('$name: $menuItem จำนวน $count'),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          cart.removeItem(menuItem);
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
