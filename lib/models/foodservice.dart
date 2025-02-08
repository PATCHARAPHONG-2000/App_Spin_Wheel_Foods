import 'package:cloud_firestore/cloud_firestore.dart';

class FoodService {
  // ฟังก์ชันดึงข้อมูลอาหาร
  Stream<QuerySnapshot> getFoodStream() {
    return FirebaseFirestore.instance.collection('foods').snapshots();
  }
}
