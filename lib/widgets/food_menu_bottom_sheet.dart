import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/menu_provider.dart';

class FoodMenuBottomSheet extends StatelessWidget {
  final TextEditingController textController;

  FoodMenuBottomSheet({required this.textController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'เมนูอาหาร',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Consumer<MenuProvider>(
              builder: (context, menuProvider, child) {
                return ListView.builder(
                  itemCount: menuProvider.items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(menuProvider.items[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          menuProvider.removeItem(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'เพิ่มเมนูอาหาร',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.add, color: Colors.blue),
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    Provider.of<MenuProvider>(context, listen: false)
                        .addItem(textController.text);
                    textController.clear();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
