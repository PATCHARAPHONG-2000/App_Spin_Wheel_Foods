import 'package:app_spinning_wheel/service/products.dart';
import 'package:app_spinning_wheel/themes/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListFood extends StatefulWidget {
  final String title;
  const ListFood({Key? key, required this.title}) : super(key: key);

  @override
  _ListFoodState createState() => _ListFoodState();
}

class _ListFoodState extends State<ListFood> {
  final FoodService _foodService = FoodService();
  final ValueNotifier<Map<String, bool>> _starredItems = ValueNotifier({});
  final ValueNotifier<Map<String, bool>> _shopredItems = ValueNotifier({});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: icons)),
        backgroundColor: primary,
        iconTheme: IconThemeData(color: icons),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
                onTap: _showListMenu,
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
                                  ? Image.network(
                                      'https://placehold.co/300x200',
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
                                        return Image.network(
                                          'https://placehold.co/300x200',
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
                              child: ValueListenableBuilder<Map<String, bool>>(
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
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: ValueListenableBuilder<
                                        Map<String, bool>>(
                                      valueListenable: _shopredItems,
                                      builder: (context, starredItems, child) {
                                        bool isStarred =
                                            starredItems[itemId] ?? false;
                                        return GestureDetector(
                                          onTap: () {
                                            _shopredItems.value = {
                                              ..._shopredItems.value,
                                              itemId: !isStarred,
                                            };
                                          },
                                          child: Icon(
                                            isStarred
                                                ? Icons.shopping_cart_sharp
                                                : Icons.shopping_cart_outlined,
                                            size: 30.0,
                                            color: isStarred ? accent : primary,
                                          ),
                                        );
                                      },
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
    );
  }

// เลือกรายการเมนู
  void _showListMenu() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // ทำให้ BottomSheet ขยายตามเนื้อหา
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.5, // 50% ของหน้าจอ
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'เลือกเมนู',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'NotoSansThai',
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                  child: ListTile(
                title: Text('sss'),
              ))
            ],
          ),
        );
      },
    );
  }
}
