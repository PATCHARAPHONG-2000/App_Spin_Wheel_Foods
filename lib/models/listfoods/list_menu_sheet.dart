import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../themes/colors.dart';
import '../cart_provider.dart';

class ListMenuSheet extends StatelessWidget {
  final QueryDocumentSnapshot item;

  ListMenuSheet({required this.item});

  @override
  Widget build(BuildContext context) {
    String name = item['name'] ?? ''; // หมวดหมู่
    List<dynamic> menuList = item['ingredients'] ?? []; // เมนูในหมวดหมู่

    return Consumer<CartProvider>(
      builder: (context, cart, child) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.all(16),
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'เลือกเมนู',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: primaryText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: menuList.length,
                      itemBuilder: (context, index) {
                        String menuItem = menuList[index].toString();
                        bool isAdded = cart.menuCounts[menuItem] != null &&
                            cart.menuCounts[menuItem]! > 0;

                        return ListTile(
                          title: Text(menuItem),
                          trailing: IconButton(
                            icon: Icon(
                              isAdded ? Icons.check : Icons.add,
                              color: isAdded ? Colors.green : Colors.blue,
                            ),
                            onPressed: () {
                              if (isAdded) {
                                cart.removeItem(menuItem);
                              } else {
                                cart.addItem(name, menuItem);
                              }
                              setState(
                                  () {}); // Refresh the state to update the icon
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
      },
    );
  }
}
