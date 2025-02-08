import 'package:cloud_firestore/cloud_firestore.dart';

class FoodService {
  final CollectionReference _foodsCollection =
      FirebaseFirestore.instance.collection('FoodMenu');

  Stream<QuerySnapshot> getFoodStream() {
    return _foodsCollection.snapshots();
  }

  Future<List<String>> getFoodList() async {
    QuerySnapshot snapshot = await _foodsCollection.get();
    return snapshot.docs.map((doc) => doc['name'] as String).toList();
  }
}
