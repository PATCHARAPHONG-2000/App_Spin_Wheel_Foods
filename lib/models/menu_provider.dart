import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuProvider extends ChangeNotifier {
  List<String> _items = [];
  List<String> _selectedItems = [];

  List<String> get items =>
      _items.isNotEmpty ? _items : defaultItems.sublist(0, 5);
  List<String> get selectedItems => _selectedItems;

  // เมนูประเภทต่าง ๆ
  final List<String> defaultItems = [
    'ผัดกะเพรา',
    'ผัดไทย',
    'ผัดซีอิ๊ว',
    'ข้าวผัด',
    'ราดหน้า',
    'ข้าวมันไก่',
    'ข้าวหมูแดง',
    'ก๋วยเตี๋ยว',
    'ข้าวขาหมู',
    'ข้าวหมูกระเทียม',
    'ต้มยำกุ้ง',
    'แกงเขียวหวาน',
    'ต้มข่าไก่',
    'แกงมัสมั่น',
    'แกงพะแนง',
    'แกงส้ม',
    'แกงป่า',
    'แกงเลียง',
    'ต้มจืด',
    'แกงฮังเล',
    'ส้มตำ',
    'ยำวุ้นเส้น',
    'ลาบ',
    'น้ำตก',
    'พล่า',
    'ยำมะม่วง',
    'ยำถั่วพู',
    'ยำปลาดุกฟู',
    'ยำหมูย่าง',
    'ยำไข่ดาว',
    'ผัดพริกขิง',
    'ผัดคะน้าหมูกรอบ',
    'ผัดผักบุ้งไฟแดง',
    'ผัดเปรี้ยวหวาน',
    'ผัดกระเพาะปลา',
    'ผัดขี้เมา',
    'ผัดฉ่า',
    'ผัดผงกะหรี่',
    'ผัดพริกเผา',
    'ผัดน้ำมันหอย',
    'ไก่ทอด',
    'ปลาทอด',
    'หมูทอด',
    'ไก่ย่าง',
    'หมูย่าง',
    'Hamburger',
    'Pizza',
    'Spaghetti',
    'Lasagna',
    'Caesar Salad',
    'Steak',
    'French Fries',
    'Chicken Wings',
    'Fish and Chips',
    'Fettuccine Alfredo',
    'Chicken Parmesan',
    'Tacos',
    'Burritos',
    'Risotto',
    'Gnocchi',
    'Frittata',
    'Pasta Carbonara',
    'Pasta Bolognese',
    'Caprese Salad',
    'Minestrone Soup',
    'Bruschetta',
    'Tiramisu',
    'Panna Cotta',
    'Cannoli',
    'Larb',
    'Papaya Salad',
    'Sticky Rice',
    'Som Tum',
    'Khao Piak',
    'Lao Grilled Pork',
    'Mok Pa',
    'Lao Sausage',
    'Baguette Sandwich',
    'Crispy Pork Skin',
  ];

  MenuProvider() {
    _loadItemsFromPrefs();
  }

  void addItem(String item) {
    _items.add(item);
    _saveItemsToPrefs();
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    _saveItemsToPrefs();
    notifyListeners();
  }

  Future<void> _saveItemsToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('menuItems', _items);
  }

  Future<void> _loadItemsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _items = prefs.getStringList('menuItems') ?? [];

    // ถ้าไม่มีข้อมูลใน SharedPreferences ให้เพิ่มเมนูเริ่มต้น 5 อย่าง
    if (_items.isEmpty) {
      _items = defaultItems.sublist(0, 5); // เลือกเมนูเริ่มต้น 5 อย่าง
      _saveItemsToPrefs();
    }

    notifyListeners();
  }

  // ฟังก์ชันในการสุ่มเลือกเมนู 5 อย่างจาก _items
  void selectRandomMenu() {
    Random random = Random();
    Set<String> selected = {};

    // ตรวจสอบว่าเมนูมีมากพอที่จะสุ่ม 5 อย่างหรือไม่
    while (selected.length < 5 && selected.length < _items.length) {
      selected.add(_items[random.nextInt(_items.length)]);
    }

    _selectedItems = selected.toList();
    notifyListeners();
  }
}
