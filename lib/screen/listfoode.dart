import 'dart:convert';

import 'package:app_spinning_wheel/screen/spinwheel.dart';
import 'package:app_spinning_wheel/service/products.dart';
import 'package:app_spinning_wheel/themes/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../models/cart_provider.dart';
import '../models/listfoods/list_menu_sheet.dart';
import '../models/listfoods/selected_items_sheet.dart';

class ListFood extends StatefulWidget {
  final String title;
  const ListFood({super.key, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _ListFoodState createState() => _ListFoodState();
}

class _ListFoodState extends State<ListFood> {
  final FoodService _foodService = FoodService();
  final ValueNotifier<Map<String, bool>> _starredItems = ValueNotifier({});

  int cartItemCount = 0; // ตัวแปรเก็บจำนวนสินค้าในตะกร้า

  // ฟังก์ชันนี้จะถูกเรียกใช้เมื่อดึงหน้าลงเพื่อรีเฟรชข้อมูล
  Future<void> _refreshData() async {
    setState(() {
      // Force refresh the stream data.
      // This will trigger the StreamBuilder to rebuild with new data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Flexible(
              child: Text(
                widget.title,
                style: TextStyle(color: icons),
                overflow: TextOverflow.ellipsis, // ตัดข้อความถ้ายาวเกิน
              ),
            ),
          ],
        ),
        backgroundColor: primary,
        iconTheme: IconThemeData(color: icons),
        actions: [
          Stack(
            children: [
              IconButton(
                onPressed: _showSelectedItems,
                icon: Icon(Icons.shopping_cart_outlined),
              ),
              Consumer<CartProvider>(
                builder: (context, cart, child) {
                  return cart.totalItemCount > 0
                      ? Positioned(
                          right: 5,
                          top: 5,
                          child: Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${cart.totalItemCount}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : SizedBox();
                },
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData, // เรียกฟังก์ชันเมื่อดึงหน้าลง
        child: StreamBuilder<QuerySnapshot>(
          stream: _foodService.getFoodStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: accent),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'เกิดข้อผิดพลาด',
                  style: TextStyle(color: secondaryText, fontSize: 18),
                ),
              );
            }

            final data = snapshot.requireData;

            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: data.size,
              itemBuilder: (context, index) {
                var item = data.docs[index];
                String itemId = item.id;

                return GestureDetector(
                  onTap: () => _showListMenu(item),
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15)),
                                child: item['imageUrl'] == null ||
                                        item['imageUrl'].toString().isEmpty
                                    ? Image.asset(
                                        'assets/images/placehold.png',
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 150,
                                      )
                                    : Image.network(
                                        item['imageUrl'],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 150,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                            'assets/images/placehold.png',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            height: 200,
                                          );
                                        },
                                      ),
                              ),
                              Positioned(
                                top: 10,
                                right: 10,
                                child:
                                    ValueListenableBuilder<Map<String, bool>>(
                                  valueListenable: _starredItems,
                                  builder: (context, starredItems, child) {
                                    bool isStarred =
                                        starredItems[itemId] ?? false;
                                    return GestureDetector(
                                      onTap: () {
                                        _starredItems.value = {
                                          ..._starredItems.value,
                                          itemId: !isStarred,
                                        };
                                      },
                                      child: Icon(
                                        isStarred
                                            ? Icons.star
                                            : Icons.star_border,
                                        size: 30.0,
                                        color: isStarred ? accent : primary,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'NotoSansThai',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                RatingBarIndicator(
                                  itemBuilder: (context, index) =>
                                      Icon(Icons.star, color: star),
                                  itemSize: 20,
                                  rating: double.tryParse(
                                          item['rating'].toString()) ??
                                      0.0,
                                ),
                                SizedBox(height: 5),
                                Text(
                                  'ประเภท: ${item['category']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'NotoSansThai',
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: divider,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    'เมนู: ${item['ingredients'].join(', ')}',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'NotoSansThai',
                                    ),
                                    maxLines: null,
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  // แสดงรายการที่เลือกทั้งหมด
  void _showSelectedItems() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SelectedItemsSheet();
      },
    );
  }

  // เลือกรายการเมนู
  void _showListMenu(QueryDocumentSnapshot item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ListMenuSheet(item: item);
      },
    );
  }
}
